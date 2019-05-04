class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if current_user && current_user.has_role?('admin')
      redirect_to admin_root_path
    end
    @hotels = Hotel.all
  end
  
  def search
    query = {}
    query[:price] = params[:price_min]..params[:price_max] if params[:price_max].present? && params[:price_min].present? 
    query[:amount_of_beds] = params[:num_beds] if params[:num_beds].present?
    @rooms = Room.joins(:hotel).where(query)
    @rooms = @rooms.where("hotels.city ILIKE ?", "%#{params[:destiny]}%")  if params[:destiny].present?
    # Validate dates taking
    if params[:start_date].present? && params[:end_date].present? 
      @rooms = @rooms.select do |room|
        room.bookings.available?(params[:start_date], params[:end_date]).empty?
      end
    end

  end

  def promotions
    @hotels = Hotel.includes(:promotions).all
  end
end
