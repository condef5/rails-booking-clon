class Api::SessionController < ApiController
  skip_before_action :authenticate_request

  def login
    token = generate_token if user

    if token.nil?
      render json: { error: "Invalid credentials" }, status: :unauthorized
    else
      render json: { auth_token: token }
    end
  end

  private

  def generate_token
    JSONWebToken.encode(user_id: user.id) if user
  end

  def user
    user = User.find_by_email(params[:email])
    user if user && user.valid_password?(params[:password])
  end
end
