class CreateSubcomments < ActiveRecord::Migration
  def change
    create_table :subcomments do |t|
    	t.text :content
    	t.belongs_to :comment
    	
      t.timestamps
    end
  end
end
