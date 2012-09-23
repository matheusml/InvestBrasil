class NotificationsController < ApplicationController

	def index
		if current_user
			@notifications = current_user.notifications	
		end
	end

	def show
		@notification = Notification.find params[:id]
		@notification.read = true
		@notification.save
		@comment = Comment.find @notification.comment_id

		company_user = CompanyUser.find @comment.company_user_id
		company_id = company_user.company_id
		@company = Company.find company_id	
	end

end
