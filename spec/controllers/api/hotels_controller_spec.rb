require 'rails_helper'

describe Api::HotelsController, type: :controller do

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
      name: 'Oro Verde',
      email: 'drupvon+hotel1@gmail.com',
      city: 'Tingo Maria',
      country: 'Peru',
      address: 'Jr. Amazonas 440' 
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index
      expect(response.status).to eq 200
    end
   
    it 'render json with all hotels' do
      get :index
      hotels = JSON.parse(response.body)
      expect(hotels.size).to eq 1
    end

  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: { id: @hotel }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct hotel' do
      get :show, params: { id: @hotel }
      expected_hotel = JSON.parse(response.body)
      expect(expected_hotel["id"]).to eq(@hotel.id)
    end

    it 'returns http status not found' do
      get :show, params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end
  
  describe 'POST create' do
    it 'returns http status created' do
      post :create, params: {
        name: 'Oro Verde',
        email: 'drupvon+hotel1@gmail.com',
        city: 'Tingo Maria',
        country: 'Peru',
        address: 'Jr. Amazonas 440'
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it 'returns the created hotel' do
      post :create, params: {
        name: 'Oro Verde',
        email: 'drupvon+hotel1@gmail.com',
        city: 'Tingo Maria',
        country: 'Peru',
        address: 'Jr. Amazonas 440'
      }
      expected_hotel = JSON.parse(response.body)
      expect(expected_hotel).to have_key("id")
      expect(expected_hotel["name"]).to eq("Oro Verde")
    end
  end

  describe 'PATCH update' do
    it 'returns http status created' do
      patch :update, params: {
        id: @hotel.id, 
        city: 'LimaCity'
      }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated hotel' do
      patch :update, params: {
        id: @hotel.id, 
        city: 'LimaCity'
      }
      expected_hotel = JSON.parse(response.body)
      expect(expected_hotel["city"]).to eq("LimaCity")
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      delete :destroy, params: { 
        id: @hotel 
      }
      expect(response).to have_http_status(:no_content)
    end
    
    it "decrement by 1 the total of hotels" do
      expect do
        delete :destroy, params: { id: @hotel }
      end.to change { Hotel.count }.by(-1)
    end
  end
end
