class Api::BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :update, :destroy]
  
  def index
    render json: Room.find(params[:room_id]).bookings
  end
  
  def show
    render json: @booking
  end
  
  def create
    booking = Booking.new(booking_params)
    if booking.save
      render json: booking, status: :created
    else
      render json: { errors: booking.errors}
    end
  end
  
  def update
    if @booking.update(booking_params)
      render json: @booking, status: :ok
    else
      render json: { errors: @booking.errors}
    end
  end
  
  def destroy
    @booking.destroy
    render json: {},status: :no_content
  end
  
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
  
  private    
  def set_booking 
    @booking = Booking.find(params[:id])
  end
  
  def booking_params
    params.permit(:start_date, :end_date, :paid_price, :room_id, :user_id)
  end
end