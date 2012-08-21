class ApplicationController < ActionController::Base
  protect_from_forgery
	helper_method :current_user
	before_filter :makes_user_admin

	def makes_user_admin
		if current_user.present?
			current_user.make_admin! if current_user.email == "matheusml@hotmail.com" and not current_user.admin?
		end
	end

  private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
end
