require 'rails_helper'

RSpec.describe Api::PromotionsRoomsController, type: :controller do
  
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

    @room = Room.create(
      name: 'Habitación simple',
      amount_of_beds: 1,
      price: 20,
      hotel_id: @hotel.id
    )
    
    @promotion = Promotion.create(
      start_date: Date.parse('10/04/2019'),
      end_date: Date.parse('30/04/2019'),
      discount_type: 'discount',
      discount_amount: 30,
      promotionable_type: 'Room',
      promotionable_id: @room.id
    )
  end
  
  # List promotions
  describe 'GET index' do    
    it 'returns http status ok' do
      get :index, params: { room_id: @room.id }
      expect(response).to have_http_status(:ok)
    end
    it 'render json with all rooms' do
      get :index, params: { room_id: @room.id }
      rooms = JSON.parse(response.body)
      expect(rooms.size).to eq 1
    end
  end
  
  # Promotion detail
  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { room_id: @room.id, id: @promotion }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct promotion' do
      get :show, params: { room_id: @room.id, id: @promotion }
      expected_promotion = JSON.parse(response.body)
      expect(expected_promotion["id"]).to eq(@promotion.id)
    end
    it 'returns http status not found' do
      get :show, params: { room_id: @room.id, id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end
  
  # Room create
  describe "POST create" do
    it "returns http status created" do
      post :create, params: { 
        start_date: Date.parse('10/03/2019'), 
        end_date: Date.parse('30/03/2019'),
        discount_type: 'discount',
        discount_amount: 30 ,
        room_id: @room.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it "returns the created promotion" do
      post :create, params: { 
        start_date: Date.parse('01/04/2019'), 
        end_date: Date.parse('28/04/2019'),
        discount_type: 'discount',
        discount_amount: 50 ,
        room_id: @room.id
      }
      expected_promotion = JSON.parse(response.body)
      expect(expected_promotion).to have_key("id")
      expect(expected_promotion["discount_amount"]).to eq(50)
    end
  end
  
  # Room update
  describe "PATCH update" do
    it "returns http status ok" do
      patch :update, params: {
        id: @promotion.id,
        room_id: @room.id,
        discount_amount: 80
      }
      expect(response).to have_http_status(:ok)
    end
    
    it "returns the updated room" do
      patch :update, params: {
        id: @promotion.id,
        room_id: @room.id,
        discount_amount: 80
      }
      expected_promotion = JSON.parse(response.body)
      expect(expected_promotion["discount_amount"]).to eq(80)
    end
  end
  
  # Room delete
  describe "DELETE destroy" do
    it "returns http status no content" do
      delete :destroy, params: { 
        id: @promotion.id,
        room_id: @room.id
      }
      expect(response).to have_http_status(:no_content)
    end

    it "returns empty body" do
      delete :destroy, params: { 
        id: @promotion.id,
        room_id: @room.id
      }
      expect(response.body).to eq("{}")
    end

    it "decrement by 1 the total of promotions" do
      expect do
        delete :destroy, params: { 
          id: @promotion.id,
          room_id: @room.id
        }
      end.to change { Promotion.count }.by(-1)
    end
  end
end
