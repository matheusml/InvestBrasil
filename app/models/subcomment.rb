#encoding: utf-8

class Subcomment < ActiveRecord::Base
	belongs_to :comment
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
