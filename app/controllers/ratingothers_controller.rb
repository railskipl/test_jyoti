class RatingothersController < ApplicationController
before_filter :check_user, only: [:new]

 def index
	
 end

 def new
  @ratingother = Ratingother.new
 end

def create
 @ratingother = Ratingother.new(params[:ratingother])
    if @ratingother.save
     redirect_to :back, notice: "Rating has been done."
    else
      render 'new'
    end
end

private
    # Use callbacks to share common setup or constraints between actions.

    def check_user
      if user_signed_in?
      else
        redirect_to root_path, :alert => "Unauthorised Access"
      end
     
    end


end
