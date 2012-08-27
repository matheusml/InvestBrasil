class Company < ActiveRecord::Base
	attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "32x32>" }
	has_many :company_users
	belongs_to :segment
	belongs_to :sector
	belongs_to :subsector
end
