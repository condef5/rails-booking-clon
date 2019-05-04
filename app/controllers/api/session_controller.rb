class Api::SessionController < ApiController
  skip_before_action :authenticate_request, only: :login

  def login
    token = generate_token if user_logged

    if token.nil?
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    else
      user_logged.update(valid_token: token)
      render json: { auth_token: token }
    end
  end

  def logout
    current_user.update(valid_token: nil)
    render json: { message: 'Your session has been destroyed.' }
  end

  private

  def generate_token
    JSONWebToken.encode(user_id: user.id) if user
  end

  def user_logged
    user = User.find_by_email(params[:email])
    user if user & user.valid_password?(params[:password])
  end
end
