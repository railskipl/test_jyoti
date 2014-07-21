class RatingothersController < ApplicationController
  # before_filter :check_user, only: [:new]

 def index
  
 end

 def new
  @ratingother = Ratingother.new
 end

def create
 
 @ratingother = Ratingother.new(params[:ratingother])
  
  unless @ratingother.email.empty?

    if @ratingother.save
      flash[:notice] = "Rating has been done."
      redirect_to encourage_signing_up_ratingothers_path
    else
      render 'new'
    end 
  else
    flash[:notice] = "No email found."
    redirect_to new_ratingother_path  
  end
end

private
    # Use callbacks to share common setup or constraints between actions.

    # def check_user
    #   if user_signed_in?
    #   else
    #     redirect_to root_path, :alert => "Unauthorised Access"
    #   end
     
    # end


end
