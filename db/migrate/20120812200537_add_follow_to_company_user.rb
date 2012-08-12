class AddFollowToCompanyUser < ActiveRecord::Migration
  def change
  	add_column :company_users, :follow, :boolean
  end
end
