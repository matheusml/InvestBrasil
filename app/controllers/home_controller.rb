class HomeController < ApplicationController
  def index
  	company_user = CompanyUser.where(:user_id => current_user.id, :follow => true)
  	if company_user.blank?
  		@comments = []
		else
			@comments = company_comments(company_user)
  	end
  end

  private

  def company_comments company_user
  	companies_ids = []
  	company_user.each do |c|
  		companies_ids << c.company_id
  	end

  	companies_users = []
  	companies_ids.each do |company_id|
			company_user = CompanyUser.where(:company_id => company_id, :user_id => current_user.id)
			companies_users << company_user
		end

		comments = []

		companies_users.each do |company_user|
			company_user.each do |c|	
				c.comments.each do |comment|
					comments << comment unless comments.include? comment
				end
			end
		end

		if comments.blank?
			[]
		else
			comments.sort_by{|c| c[:updated_at]}.reverse
		end
	end
end