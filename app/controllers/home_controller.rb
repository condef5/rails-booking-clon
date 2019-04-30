class HomeController < ApplicationController
  def index
    if current_user && current_user.has_role?('admin')
      redirect_to admin_root_path
    end
  end
end
