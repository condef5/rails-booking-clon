require 'rails_helper'

RSpec.describe Api::PromotionsHotelsController, type: :controller do

  def authorization_header
    user = User.create(
      email: "space@gmail.com",
      name:'space',
      password:'secret123',
      role:'admin'
    )
    token = JSONWebToken.encode(user_id: user.id)
    { 'Authorization': "Bearer #{token}" }
  end

  before do
    request.headers.merge!(authorization_header)
    @hotel = Hotel.create(
      name: 'Oro Verder',
      email: 'drupvon+hotel@gmail.com',
      city: 'Tingo Maria',
      country: 'Peru',
      address: 'Jr arequipa 440'
    )
    @promotion = Promotion.create(
      start_date: Date.parse('28-04-2019'),
      end_date: Date.parse('30-04-2019'),
      discount_type: ['percentage', 'fixed'].sample,
      discount_amount: rand(50) + 1,
      promotionable_type: "Hotel",
      promotionable_id: @hotel.id
    )
  end

  # List rooms
  describe 'GET index' do    
    it 'returns http status ok' do
      get :index, params: { hotel_id: @hotel.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render json with all rooms' do
      get :index, params: { hotel_id: @hotel.id }
      promotions = JSON.parse(response.body)
      expect(promotions.size).to eq 1
    end
  end

  # Rooms detail
  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { 
        id: @promotion,
        hotel_id: @hotel.id
      }
      expect(response).to have_http_status(:ok)
    end
    
    it 'render the correct room' do
      get :show, params: { 
        id: @promotion,
        hotel_id: @hotel.id
      }
      expected_room = JSON.parse(response.body)
      expect(expected_room["id"]).to eq(@promotion.id)
    end

    it 'returns http status not found' do
      get :show, params: { 
        id: 'xxx',
        hotel_id: @hotel.id
      }
      expect(response).to have_http_status(:not_found)
    end
  end

  #Room create
  describe "POST create" do
    it "returns http status created" do
      post :create, params: { 
        start_date: Date.parse('28-04-2019'),
        end_date: Date.parse('30-04-2019'),
        discount_type: ['percentage', 'fixed'].sample,
        discount_amount: rand(50) + 1,
        hotel_id: @hotel.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created room" do
      post :create, params: { 
        start_date: Date.parse('28-04-2019'),
        end_date: Date.parse('30-04-2019'),
        discount_type: ['percentage', 'fixed'].sample,
        discount_amount: rand(50) + 1,
        hotel_id: @hotel.id
      }
      expected_room = JSON.parse(response.body)
      expect(expected_room).to have_key("id")
      expect(expected_room["end_date"]).to eq("2019-04-30")
    end
  end

  # Room update
  describe "PATCH update" do
    it "returns http status ok" do
      patch :update, params: {
        id: @promotion.id,
        hotel_id: @hotel.id,
        discount_type: ['percentage', 'fixed'].sample,
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the updated room" do
      patch :update, params: {
        id: @promotion.id,
        hotel_id: @hotel.id,
        start_date: Date.parse('29-04-2019')
      }
      expected_room = JSON.parse(response.body)
      expect(expected_room["start_date"]).to eq('2019-04-29')
    end
  end

  # Room delete
  describe "DELETE destroy" do
    it "returns http status no content" do
      delete :destroy, params: { 
        id: @promotion.id,
        hotel_id: @hotel.id
      }
      expect(response).to have_http_status(:no_content)
    end
    
    it "returns empty body" do
      delete :destroy, params: { 
        id: @promotion.id,
        hotel_id: @hotel.id
      }
      expect(response.body).to eq("{}")
    end
    
    it "decrement by 1 the total of rooms" do
      expect do
        delete :destroy, params: { 
          id: @promotion.id,
          hotel_id: @hotel.id
        }
      end.to change { Promotion.count }.by(-1)
    end
    
    it "actually delete the room" do
      delete :destroy, params: { 
        id: @promotion.id,
        hotel_id: @hotel.id
      }
      room_deleted = Room.where(
        id: @promotion.id,
        hotel_id: @hotel.id
      )
      expect(room_deleted.size).to eq(0)
    end
  end

end
