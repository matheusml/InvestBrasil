class CompanyUser < ActiveRecord::Base
	belongs_to :company
	belongs_to :user
	has_many :comments
end
