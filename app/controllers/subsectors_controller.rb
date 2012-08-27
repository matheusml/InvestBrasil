class SubsectorsController < ApplicationController

	def show
		@subsector = Subsector.find params[:subsector_id]
		@companies = Company.where(:subsector_id => params[:subsector_id])
	end

end
