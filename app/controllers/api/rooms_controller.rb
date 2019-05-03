class Api::RoomsController < ApiController
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    if params[:hotel_id].present?
      render json: Hotel.find(params[:hotel_id]).rooms
    else
      query = {}
      if params[:price_max].present? && params[:price_min].present?
        query[:price] = params[:price_min]..params[:price_max]
      end
      query[:amount_of_beds] = params[:num_beds] if params[:num_beds].present?
      @rooms = Room.where(query)
      render json: @rooms 
    end
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
