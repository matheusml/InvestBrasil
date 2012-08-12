class UsersController < ApplicationController
	def follow_company
		CompanyUser.create :user_id => session[:user_id],
											 :company_id => params[:company_id],
											 :follow => true
		redirect_to company_path params[:company_id]	 									 
	end

	def unfollow_company
		company_user = CompanyUser.where(:user_id => session[:user_id],
																:company_id => params[:company_id],
																:follow => true).first
		company_user.update_attributes :follow => nil

		redirect_to company_path params[:company_id]
	end
end
