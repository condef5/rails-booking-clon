class RoomsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @rooms = Room.all
  end

  def reserve
    if current_user.nil?
      flash[:alert] = "You need to sign in to reserve this room"
      session[:room_id] = params[:room_id]
      redirect_to "/users/sign_in"
    elsif params[:room_id].present?
      @room = Room.find(params[:room_id])
      render "reserve/index"
    else
      redirect_to rooms_path
    end
  end

  def reserve_save
    @room = Room.find(params[:room_id])
    if params[:start_date].present? && params[:end_date].present?
      @bookings = @room.bookings
      if @bookings.available?(params[:start_date], params[:end_date]).empty?
        current_user.bookings.create(
          start_date: Date.parse(params[:start_date]), 
          end_date: Date.parse(params[:end_date]),
          paid_price: @room.discount,
          room_id: @room.id
        )
        session[:room_id] = nil if session[:room_id] 
        redirect_to root_path, notice: 'Room booked was successfully rented.'
      else
        flash[:notice] = 'This room is already booked in dates'
        render "reserve/index"
      end
    else
      flash[:notice] = 'start_date and end_date are required'
      render "reserve/index"
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to rooms_path, notice: 'The room does not exist'
  end

end
