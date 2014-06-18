class RatingothersController < ApplicationController


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


end
