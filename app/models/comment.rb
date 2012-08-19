#encoding: utf-8

class Comment < ActiveRecord::Base
	belongs_to :company_users
	has_many :subcomments
	belongs_to :user

	def owner
		user = User.find self.user_id
		if user
			user.name
		else
			'Usuário não existe mais'
		end
	end
end
