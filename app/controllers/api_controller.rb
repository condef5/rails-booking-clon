class ApiController < ActionController::API
  include Pundit
  attr_reader :current_user
  before_action :authenticate_request
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def authenticate_request
    @current_user = user
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def user
    return unless decoded_auth_token

    user_id = decoded_auth_token[:user_id]
    User.find_by(id: user_id, valid_token: http_auth_header)
  end

  def decoded_auth_token
    @decoded_auth_token ||= JSONWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if request.headers['Authorization'].present?
      return request.headers['Authorization'].split(' ').last
    end
  end

  def user_not_authorized
    render json: { error: 'Unnecessary permissions' }, status: 403
  end
end
