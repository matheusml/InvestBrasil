class CompaniesController < ApplicationController
	def index
		@companies = Company.all
	end

	def show
		@company = Company.find params[:id]
		@comments = company_comments(@company.id).paginate(:page => params[:page], :per_page => 2)		
	end

	def new
		if current_user && current_user.admin?
			@company = Company.new
		else
			redirect_to companies_path
		end
	end

	def create
		@company = Company.new params[:company]
		
		if @company.save
			redirect_to companies_path, :notice => 'Empresa criada com sucesso'			
		else
			render 'new'
		end
	end

	def edit
		if current_user && current_user.admin?
			@company = Company.find params[:id]
		else
			redirect_to companies_path
		end
	end

	def update
		if current_user && current_user.admin?
			@company = Company.find params[:id]
			
			if @company.update_attributes params[:company]
				redirect_to companies_path, :notice => 'Empresa atualizada com sucesso'			
			else
				render 'edit'
			end
		else
			redirect_to companies_path
		end
	end

	def destroy
		if current_user && current_user.admin?
			company = Company.find params[:id]
			company.destroy

			redirect_to companies_path, :notice => 'Empresa deletada com sucesso'
		else
			redirect_to companies_path
		end
	end

	def create_comment
		company_user = CompanyUser.where(:company_id => params[:company_id],
																			:user_id => session[:user_id]).first
		if company_user.blank?																	
			company_user = CompanyUser.create :company_id => params[:company_id],
																				:user_id => session[:user_id]
		end

		comment = Comment.create :content => params[:content],
														 :company_user_id => company_user.id,
														 :user_id => session[:user_id]

		redirect_to company_path params[:company_id]												 
	end

	def create_subcomment
		subcomment = Subcomment.create :content => params[:content],
																	 :comment_id => params[:comment_id],
																	 :user_id => session[:user_id]
		comment = Comment.find params[:comment_id]
		comment.update_attributes :updated_at => Time.zone.now

		users = []
		users << comment.user
		comment.subcomments.each do |subcomment|
			users << subcomment.user unless users.include? subcomment.user
		end

		users.each do |user|
			notification = Notification.where(:comment_id => comment.id, :user_id => user.id)
			if notification.present?
		  	notification.first.update_attributes :read => nil
		  else
		  	Notification.create :comment_id => comment.id, :user_id => user.id
			end
		end

		redirect_to company_path params[:company_id]
	end

	def create_subcomment_in_notifications
		subcomment = Subcomment.create :content => params[:content],
																	 :comment_id => params[:comment_id],
																	 :user_id => session[:user_id]
		comment = Comment.find params[:comment_id]
		comment.update_attributes :updated_at => Time.zone.now

		users = []
		users << comment.user
		comment.subcomments.each do |subcomment|
			users << subcomment.user unless users.include? subcomment.user
		end

		users.each do |user|
			notification = Notification.where(:comment_id => comment.id, :user_id => user.id)
			if notification.present?
				notification = notification.first
		  	notification.update_attributes :read => nil
		  else
		  	notification = Notification.create :comment_id => comment.id, :user_id => user.id
			end
			redirect_to notification_path(notification)
		end
	end

	def companies_ajax
		if params[:term]
      like = "%".concat(params[:term].concat("%"))
      companies = Company.where("name like ?", like)
    else
      companies = Company.all
    end
    list = companies.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
	end

	def redirect_to_correct_company
		company = Company.find_by_name params[:company]
		if company
			redirect_to company_path company
		else
			redirect_to companies_path
		end
	end

	private

	def company_comments company_id
		company_user = CompanyUser.where :company_id => company_id
		comments = []

		unless company_user.blank?
			company_user.each do |c|
				c.comments.each do |comment|
					comments << comment 
				end
			end
		end

		comments.sort_by{|c| c[:updated_at]}.reverse
	end

end
