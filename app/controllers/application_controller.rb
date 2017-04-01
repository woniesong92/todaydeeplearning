class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_login
    unless current_user
      flash[:error] = "Please login first :)"
      redirect_to new_user_registration_path
    end
  end
end
