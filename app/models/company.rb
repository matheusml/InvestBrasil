class Company < ActiveRecord::Base
	has_many :company_users
end
