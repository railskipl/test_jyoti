class DashboardController < ApplicationController
  before_filter :authenticate_user!
	def index
		@feedbacks = Feedback.all
	end

	
end
