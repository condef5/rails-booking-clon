require 'rails_helper'

RSpec.describe Api::RoomsController, type: :controller do
  
  def authorization_header
    user = User.create(
      email: "space@gmail.com",
      name:'space',
      password:'secret123',
      role:'admin'
    )
    token = JSONWebToken.encode(user_id: user.id)
    user.update(valid_token: token)
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
      name: 'Single',
      amount_of_beds: 1,
      price: 20,
      hotel_id: @hotel.id
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
      rooms = JSON.parse(response.body)
      expect(rooms.size).to eq 1
    end
    it 'returns http status ok when get one room data' do
      get :index, params: { hotel_id: @hotel.id }
      expect(response).to have_http_status(:ok)
    end
  end

  # Rooms detail
  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { hotel_id: @hotel.id, id: @room }
      expect(response).to have_http_status(:ok)
    end
    it 'render the correct room' do
      get :show, params: { hotel_id: @hotel.id, id: @room }
      expected_room = JSON.parse(response.body)
      expect(expected_room["id"]).to eq(@room.id)
    end
    it 'returns http status not found' do
      get :show, params: { hotel_id: @hotel.id, id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  # #Room create
  describe "POST create" do
    it "returns http status created" do
      post :create, params: { 
        name: 'Single',
        amount_of_beds: 1,
        price: 20,
        hotel_id: @hotel.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end
    it "returns the created room" do
      post :create, params: { 
        name: 'Single',
        amount_of_beds: 1,
        price: 20,
        hotel_id: @hotel.id
      }
      expected_room = JSON.parse(response.body)
      expect(expected_room).to have_key("id")
      expect(expected_room["name"]).to eq("Single")
    end
  end

  # #Room update
  describe "PATCH update" do
    it "returns http status ok" do
      patch :update, params: {
        id: @room.id,
        hotel_id: @hotel.id,
        name: "Double"
      }
      expect(response).to have_http_status(:ok)
    end
    it "returns the updated room" do
      patch :update, params: {
        id: @room.id,
        hotel_id: @hotel.id,
        name: "Double"
      }
      expected_room = JSON.parse(response.body)
      expect(expected_room["name"]).to eq("Double")
    end
  end

  # #Room delete
  describe "DELETE destroy" do
    it "returns http status no content" do
      delete :destroy, params: { 
        id: @room.id,
        hotel_id: @hotel.id
      }
      expect(response).to have_http_status(:no_content)
    end
    it "returns empty body" do
      delete :destroy, params: { 
        id: @room.id,
        hotel_id: @hotel.id
      }
      expect(response.body).to eq("{}")
    end
    it "decrement by 1 the total of rooms" do
      expect do
        delete :destroy, params: { 
          id: @room.id,
          hotel_id: @hotel.id
        }
      end.to change { Room.count }.by(-1)
    end
    it "actually delete the room" do
      delete :destroy, params: { 
        id: @room.id,
        hotel_id: @hotel.id
      }
      room_deleted = Room.where(
        id: @room.id,
        hotel_id: @hotel.id
      )
      expect(room_deleted.size).to eq(0)
    end
  end
end
