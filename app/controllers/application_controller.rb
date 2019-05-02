class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!, :except => [:show, :index]
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  layout :render_layout

  def after_sign_in_path_for(current_user)
    if current_user.has_role?('admin')
      return admin_root_path
    else
      return root_path
    end
  end

  private
  def render_layout
    if current_user && current_user.has_role?('admin')
      'admin'
    else
      'application'
    end
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    if current_user.nil?
      redirect_to "/users/sign_in"
    else
      redirect_to "/"
    end
  end
end
