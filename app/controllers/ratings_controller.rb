class RatingsController < ApplicationController

def index
	
end

def new
 @rating = Rating.new
end

def create
 @rating = Rating.new(params[:rating])
    if @rating.save
     redirect_to :back, notice: "Users has been rated."
    else
      render 'new'
    end
	
end

end
