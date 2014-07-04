class RatingsController < ApplicationController
 before_filter :check_user, only: [:new]
  
def index
	
end

def new
 @rating = Rating.new
 @powergroup = PowerGroup.where('user_id = ?', current_user.id) rescue nil
 @c = []
 @powergroup.each do |r|
   @c << User.where('email = ?', r.email).select('id')
 end
 
 @d = Rating.power_mirrors(@c, current_user.id)#power mirrors
 if @d.empty?
  @d = [0,0,0,0,0,0,0,0]
 else
  @d = Rating.power_mirrors(@c, current_user.id)#power mirrors
 end

 @ratingss = Rating.where('user_id = ?', current_user.id) rescue nil#self image
 @ratingother = Ratingother.where('friend_id = ?', current_user.id) rescue nil#all mirrors
 if @ratingother.empty? && @ratingss.empty?
  @b = [0,0,0,0,0,0,0,0]#self image
  @a = [0,0,0,0,0,0,0,0]#all mirrors
 elsif @ratingother.empty? && @ratingss != nil
  @b = Rating.self_mirrors(@ratingss, current_user.id)#self image
  @a = [0,0,0,0,0,0,0,0]#all mirrors
 elsif @ratingss.empty? && @ratingother != nil
  @b = [0,0,0,0,0,0,0,0]#self image
  @a = Rating.all_mirrors(@ratingother,current_user.id) #all mirrors  
 else
  @b = Rating.self_mirrors(@ratingss, current_user.id)#self image
  @a = Rating.all_mirrors(@ratingother,current_user.id) #all mirrors  
 end

 @over = add_array(@a, @b) #added to array
 @w = add_array(@over , @d) # added over array with @d array
 @q = @w.inject{ |sum, el| sum + el }.to_f / @w.size # overall impression
 
end

def add_array(a,b)
  a.zip(b).map{|pair| pair.reduce(&:+) }
end

def create
 @q = Rating.where('user_id = ?', current_user.id)
 if @q.empty?
   @rating = Rating.new(params[:rating])
   if @rating.save
     redirect_to :back, notice: "Users has been rated."
    else
      render 'new'
    end
 else
   @ratings = Rating.find(@q[0].id)
   @rating = @ratings.update_attributes(params[:rating])
   redirect_to :back, notice: "Users has been rated."
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
