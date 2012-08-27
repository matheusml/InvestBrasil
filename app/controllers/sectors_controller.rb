class SectorsController < ApplicationController

	def show
		@sector = Sector.find params[:sector_id]
		@companies = Company.where(:sector_id => params[:sector_id])
	end

end
