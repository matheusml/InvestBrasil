class AddFieldsToCompanies < ActiveRecord::Migration
  def change
  	add_column :companies, :sector_id, :integer
  	add_column :companies, :subsector_id, :integer
  	add_column :companies, :segment_id, :integer
  	add_column :companies, :activity, :string
  	add_column :companies, :listing_segment, :string
  	add_column :companies, :market_value, :string
  	add_column :companies, :website, :string
  end
end
