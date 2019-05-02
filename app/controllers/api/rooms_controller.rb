class Api::RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    render json: Hotel.find(params[:hotel_id]).rooms
  end

  def show
    render json: @room
  end

  def create
    room = Room.new(room_params)
    if room.save
      render json: room, status: :created
    else
      render json: { errors: room.errors }
    end
  end

  def update
    if @room.update(room_params)
      render json: @room, status: :ok
    else
      render json: { errors: @room.errors}
    end
  end

  def destroy
    @room.destroy
    render json: {},status: :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private    
  def set_room 
    @room = Room.find(params[:id])
  end

  def room_params
    params.permit(:name, :amount_of_beds, :price, :hotel_id)
  end
end
