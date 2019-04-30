class ApplicationController < ActionController::Base
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
end
