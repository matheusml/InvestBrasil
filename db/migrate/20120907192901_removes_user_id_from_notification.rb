class RemovesUserIdFromNotification < ActiveRecord::Migration
  def change
  	remove_column :notifications, :users_id
  end
end
