class Admin::HotelsController < ApplicationController

    def index
      @hotels = Hotel.all
    end
    def show
      @hotel = Hotel.find(params[:id])
    end
  
    def new
        @hotel = Hotel.new
    end

    def create
        @hotel = Hotel.new(hotel_params)
        if @hotel.save
          redirect_to admin_hotel_path(@hotel), notice: 'hotel was successfully created.'
        else
          render :new
        end
    end

    def hotel_params
      params.require(:hotel).permit(:name ,:email ,:city ,:country ,:address)
    end

end
