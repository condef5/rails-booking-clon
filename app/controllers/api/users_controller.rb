class Api::UsersController < ApiController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    authorize([:api, User])
    render json: User.all 
  end

  def show
    authorize([:api, @user])
    render json: @user 
  end

  def profile
    render json: current_user
  end

  def create
    user = User.new(user_params)
    authorize([:api, user])
    if user.save
      render json: user, status: :created
    else 
      render json: {errors: user.errors}
    end
  end

  def update
    authorize([:api, @user])
    if @user.update(user_params)
      render json: @user, status: :ok
    else 
      render json: {errrors: user.errors}
    end
  end

  def destroy
    authorize([:api, @user])
    @user.destroy
    render json: {}, status: :no_content 
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {message: e.message}, status: :not_found
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.permit(:name, :email, :password, :role)
  end
end
