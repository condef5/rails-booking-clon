class Admin::PromotionsController < ApplicationController
  before_action :set_promotion, only: [:index, :new, :show, :edit, :create, :update]

  def index
    @promotions = @hotel.promotions
    authorize [:admin,  @promotions]
  end

  def new
    @promotion = Promotion.new
    authorize [:admin,  @promotion]
  end

  def show
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
  end

  def edit
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
  end

  def create
    @promotion = @hotel.promotions.new(promotions_params)
    authorize [:admin,  @promotion]
    if @promotion.save
      redirect_to admin_hotel_path(@hotel), notice: 'Promotion was successfully created.'
    else
      render :new
    end
  end

  def update 
    @promotion = Promotion.find(params[:id])
    authorize [:admin,  @promotion]
    if @promotion.update(promotions_params)
      redirect_to admin_hotel_promotions_path(@hotel), notice: 'Promotion was successfully updated'
    else 
      render :new
    end
  end

  private
  def set_promotion
    @hotel = Hotel.find(params[:hotel_id])
  end

  def promotions_params
    params.require(:promotion).permit(:start_date, :end_date, :discount_type, :discount_amount)
  end
end
