class Admin::PromotionsRoomsController < ApplicationController
  before_action :set_room, only: [:index, :new, :show, :edit, :create, :update]
  before_action :set_promotion, only: [:show, :edit, :update, :destroy]

  def index
    @promotions = @room.promotions
    authorize [:admin,  @promotions]
  end

  def new
    @promotion = Promotion.new
    authorize [:admin,  @promotion]
  end

  def show 
    authorize [:admin,  @promotion]
  end

  def edit 
    authorize [:admin,  @promotion]
  end

  def create
    @promotion = @room.promotions.new(promotion_params)
    authorize [:admin,  @promotion]
    if @promotion.save
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully created'
    else 
      render :new
    end
  end

  def update
    authorize [:admin,  @promotion]
    if @promotion.update(promotion_params)
      redirect_to admin_room_promotions_path(@room), notice: 'Promotion was successfully updated'
    else 
      render :new
    end
  end

  def destroy
    @promotion.destroy
    redirect_to admin_room_promotions_path, notice: 'Promotion was successfully destroyed.'
  end

  private
  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:start_date, :end_date, :discount_type, :discount_amount)
  end
end