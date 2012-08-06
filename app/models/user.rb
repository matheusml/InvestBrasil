class User < ActiveRecord::Base
	has_many :company_users
end
