class Comment < ActiveRecord::Base
	belongs_to :company_users
	has_many :subcomments
end
