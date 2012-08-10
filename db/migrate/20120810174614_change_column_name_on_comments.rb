class ChangeColumnNameOnComments < ActiveRecord::Migration
  def change
    rename_column :comments, :company_users_id, :company_user_id
  end
end
