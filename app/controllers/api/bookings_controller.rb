class Api::BookingsController < ApiController
  before_action :set_booking, only: [:show, :update, :destroy]
  
  def index
    authorize([:api, Booking])
    if params[:room_id].present?
      render json: Room.find(params[:room_id]).bookings
    else
      if current_user.role == "regular"
        render json: current_user.bookings
      else
        render json: Booking.all
      end
    end
  end
  
  def show
    authorize([:api, @booking])
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
    authorize([:api, @booking])
    if @booking.update(booking_params)
      render json: @booking, status: :ok
    else
      render json: { errors: @booking.errors}
    end
  end
  
  def destroy
    authorize([:api, @booking])
    @booking.destroy
    render json: {}, status: :no_content
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
