class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users do |t|
    	t.belongs_to :company
    	t.belongs_to :user

      t.timestamps
    end
  end
end
