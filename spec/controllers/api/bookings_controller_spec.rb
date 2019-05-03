require 'rails_helper'

RSpec.describe Api::BookingsController, type: :controller do
  
  def authorization_header
    user = User.create(
      email: "space@gmail.com",
      name: 'space',
      password: 'secret123',
      role: 'admin'
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
    @user = User.create(
      email: "mperezzevallos+regular@gmail.com", 
      name: 'lucas', 
      password: 'regular', 
      role: 'regular'
    )
    @booking = Booking.create(
      start_date: Date.parse('01-05-2019'), 
      end_date: Date.parse('05-05-2019'), 
      paid_price: 20,
      room_id: @room.id,
      user_id: @user.id
    )
  end

  describe 'GET index' do
    it 'returns http status ok' do
      get :index, params: {
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expect(response.status).to eq 200
    end

    it 'render json with all bookings' do
      get :index, params: {
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      bookings = JSON.parse(response.body)
      expect(bookings.size).to eq 1
    end
  end

  describe 'GET show' do
    it 'returns http status ok' do
      get :show, params: {
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expect(response).to have_http_status(:ok)
    end

    it 'render the correct booking' do
      get :show, params: { 
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expected_booking = JSON.parse(response.body)
      expect(expected_booking["id"]).to eq(@booking.id)
    end

    it 'returns http status not found' do
      get :show, params: { 
        id: 'xxx',
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST create' do
    it 'returns http status created' do
      post :create, params: {
        start_date: Date.parse('01-05-2019'), 
        end_date: Date.parse('05-03-2019'), 
        paid_price: 20, 
        room_id: @room.id,
        user_id: @user.id,
        hotel_id: @hotel.id
      }
      expect(response.status).to eq(201)
      expect(response).to have_http_status(:created)
    end

    it 'returns the created booking' do
      post :create, params: {
        start_date: Date.parse('01-05-2019'), 
        end_date: Date.parse('05-03-2019'), 
        paid_price: 20, 
        room_id: @room.id,
        user_id: @user.id,
        hotel_id: @hotel.id
      }
      expected_booking = JSON.parse(response.body)
      expect(expected_booking).to have_key("id")
      expect(expected_booking["paid_price"]).to eq(20)
    end
  end

  describe 'PATCH update' do
    it 'returns http status created' do
      patch :update, params: {
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id,
        start_date: Date.parse('05-05-2019'), 
        end_date: Date.parse('09-05-2019')
      }
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated hotel' do
      hotel = Hotel.create(@hotel_params)
      patch :update, params: {
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id,
        start_date: Date.parse('05-05-2019'),
        end_date: Date.parse('09-05-2019'),
        paid_price: 10
      }
      expected_hotel = JSON.parse(response.body)
      expect(expected_hotel["paid_price"]).to eq(10)
    end
  end

  describe "DELETE destroy" do
    it "returns http status no content" do
      delete :destroy, params: { 
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expect(response).to have_http_status(:no_content)
    end
    it "returns empty body" do
      delete :destroy, params: { 
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      expect(response.body).to eq("{}")
    end
    it "decrement by 1 the total of bookings" do
      expect do
        delete :destroy, params: { 
          id: @booking.id,
          hotel_id: @hotel.id,
          room_id: @room.id
        }
      end.to change { Booking.count }.by(-1)
    end
    it "actually delete the booking" do
      delete :destroy, params: { 
        id: @booking.id,
        hotel_id: @hotel.id,
        room_id: @room.id
      }
      booking_deleted = Booking.where(
        id: @booking.id
      )
      expect(booking_deleted.size).to eq(0)
    end
  end

end
