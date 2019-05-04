class HotelsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @hotels = Hotel.all
  end

  def show
    @hotel = Hotel.find(params[:id])
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    redirect_to rooms_path, notice: 'The hotel does not exist'
  end

end
