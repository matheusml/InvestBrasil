class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
    	t.belongs_to :users
    	t.integer :comment_id
    	t.boolean :read

      t.timestamps
    end
  end
end
