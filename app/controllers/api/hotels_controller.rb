class Api::HotelsController < ApiController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]

  def index
    @hotels = Hotel.all
    render json: @hotels
  end

  def edit
  end

  def show
    render json: @hotel
  end

  def create
  end

  def update
  end

  def destroy
  end

  private    
  def set_hotel 
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params.require(:hotel).permit(:name, :email, :city, :country,  :address, :image, gallery: [])
  end
end