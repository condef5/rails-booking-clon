class Admin::PromotionsRoomsController < ApplicationController

  def index
    @room = Room.find(params[:room_id])
    @promotions = @room.promotions
    authorize [:admin,  @promotions]

  end

  def new
    @room = Room.find(params[:room_id])
    @promotion = Promotion.new
    authorize [:admin,  @promotion]
  end

  def show 
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
  end

  def edit 
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
  end

  def create
    @room = Room.find(params[:room_id])
    @promotion = @room.promotions.new(promotion_params)
    authorize [:admin,  @promotion]
    if @promotion.save
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully created'
    else 
      render :new
    end
  end

  def update
    @room = Room.find(params[:room_id])
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
    if @promotion.update(promotion_params)
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully updated'
    else 
      render :new
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:start_date, :end_date, :discount_type, :discount_amount)
  end
end