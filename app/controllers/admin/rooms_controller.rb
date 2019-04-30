class Admin::RoomsController < ApplicationController

  def new
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.new
  end

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.new(hotel_params)
    if @room.save
      redirect_to admin_hotel_path(@hotel), notice: 'Room was successfully created.'
    else
      render :new
    end
  end

  def show
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.find(params[:id])
  end

  private
  def hotel_params
    params.require(:room).permit(:name ,:amount_of_beds ,:price)
  end

end
