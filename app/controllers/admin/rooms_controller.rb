class Admin::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]

  def new
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.new
  end

  def show
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.find(params[:id])
  end

  def edit
  end

  def create
    @hotel = Hotel.find(params[:hotel_id])
    @room = @hotel.rooms.new(room_params)
    if @room.save
      redirect_to admin_hotel_room_path(@hotel, @room), notice: 'Room was successfully created.'
    else
      render :new
    end
  end
  
  def update
    if @room.update(room_params)
      redirect_to admin_hotel_room_path(@hotel, @room), notice: 'Room was successfully updated.'
    else
      render :edit
    end
  end

  private
  def set_room
    @hotel = Hotel.find(params[:hotel_id])
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :amount_of_beds, :price, :image, gallery: [])
  end

end
