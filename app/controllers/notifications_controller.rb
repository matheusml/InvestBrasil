class NotificationsController < ApplicationController

	def index
		@notifications = current_user.notifications	
	end

	def show
		@notification = Notification.find params[:id]
		@comment = Comment.find @notification.comment_id

		company_user = CompanyUser.find @comment.company_user_id
		company_id = company_user.company_id
		@company = Company.find company_id	
	end

end
