class SegmentsController < ApplicationController

	def show
		@segment = Segment.find params[:segment_id]
		@companies = Company.where(:segment_id => params[:segment_id])
	end

end
