class CompaniesController < ApplicationController
	def index
		@companies = Company.all
	end

	def show
		@company = Company.find params[:id]
		@comments = company_comments @company.id
	end

	def new
		@company = Company.new
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
		@company = Company.find params[:id]
	end

	def update
		@company = Company.find params[:id]
		
		if @company.update_attributes params[:company]
			redirect_to companies_path, :notice => 'Empresa atualizada com sucesso'			
		else
			render 'edit'
		end
	end

	def destroy
		company = Company.find params[:id]
		company.destroy

		redirect_to companies_path, :notice => 'Empresa deletada com sucesso'
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
		redirect_to company_path params[:company_id]
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

		comments
	end

end
