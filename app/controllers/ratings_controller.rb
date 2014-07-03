class RatingsController < ApplicationController
 before_filter :check_user, only: [:new]
  
def index
	
end

def new
 @rating = Rating.new
 @powergroup = PowerGroup.where('user_id = ?', current_user.id)
 @c = []
 @powergroup.each do |r|
   @c << User.where('email = ?', r.email).select('id')
 end
 
 #@d = Rating.power_mirrors(@c, current_user.id)
 @ratingss = Rating.where('user_id = ?', current_user.id) #self image
 @b = Rating.self_mirrors(@ratingss, current_user.id)#self image
 @ratingother = Ratingother.where('friend_id = ?', current_user.id)#all mirrors
 @a = Rating.all_mirrors(@ratingother,current_user.id) #all mirrors

end

def create
 @rating = Rating.new(params[:rating])
 #raise @rating.inspect
    if @rating.save
     redirect_to :back, notice: "Users has been rated."
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
