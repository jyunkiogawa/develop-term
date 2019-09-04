class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
 
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  # def store_location
  #   session[:forwarding_url] = request.original_url if request.get?
  # end

  #   def logged_in_user?
  #   unless logged_in?
  #     store_location
  #     flash.now[:danger] = "ログインしてください"
  #     redirect_to "/logged_in"
  #   end
  # end
  
end
