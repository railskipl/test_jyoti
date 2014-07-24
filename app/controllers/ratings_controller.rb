class RatingsController < ApplicationController
 before_filter :check_user, only: [:new]
  before_filter :authenticate_user!
def index
	
end

def new
 # @q = Rating.where('user_id = ?', current_user.id)
 @rating = Rating.new
end

def add_array(a,b)
  a.zip(b).map{|pair| pair.reduce(&:+) }
end

def reputation_report
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
   @all_mirror = add_array(@over , @d) # added over array with @d array
   @w = []
   @all_mirror.each do |r|
    @w << (r.to_f / 3).to_f
  end
   @aa = @all_mirror.inject{ |sum, el| sum + el }.to_f / @w.size 
   @q = @aa/3 # overall impression
   # @avg = AvgRating.where("user_id = ?",current_user.id).first_or_create
   # unless @w.empty?
   #   @avg.overall = @w[0]
   #   @avg.trustworthy = @w[1]
   #   @avg.kind_helpful = @w[2]
   #   @avg.potential = @w[3]
   #   @avg.presentable = @w[4]
   #   @avg.perform_well = @w[5]
   #   @avg.emotianally_mature = @w[6]
   #   @avg.friendly_social = @w[7]
   #   @avg.user_id = current_user.id
   #   @avg.save
   # end
   # report
end

def create
 @q = Rating.where('user_id = ?', current_user.id)
 if @q.empty?
   @rating = Rating.new(params[:rating])
   if @rating.save
     redirect_to reputation_report_path, notice: "Users has been rated."
    else
      render 'new'
    end
 else
   @ratings = Rating.find(@q[0].id)
   @rating = @ratings.update_attributes(params[:rating])
   redirect_to reputation_report_path, notice: "Users has been rated."
 end
end

def report
  @user = current_user
  @total_ratings = Ratingother.where("email like ?" ,@user.email).count
  @recent_ratings = Ratingother.where("email like ? and created_at >= ?" ,@user.email, 6.months.ago).count
  @total_relations = Relationship.where("email like ?" ,@user.email).count
  if @total_ratings > 0 && @total_relations > 0
    @percent = @recent_ratings*100/@total_ratings
  
    @long_relations = Relationship.where("email like ? and know_how_for_long_year >= ?" ,@user.email,2).count
    @percent_history = @long_relations*150/@total_relations
    @tr = Ratingother.where("email like ?" ,@user.email)
    if @total_ratings > 100
      @diversity_points = 150
    else
      @diversity_points = (@total_ratings*150)/100
    end
    
    @weighted_rating ||= []
    @tr.each do |r| 
     @weighted_rating << ((r.trustworthy*0.2 + r.kind_helpful*0.1 + r.potential*0.1 + r.perform_well*0.2 + r.presentable*0.1+ r.emotianally_mature*0.15 + r.friendly_social*0.15)*(ReputationScore.find_by_user_id(r.user_id).score*0.1)).to_i
    end 
    @total_score = @percent + @percent_history + @diversity_points + @weighted_rating.sum/@total_ratings 
    r = ReputationScore.where("user_id = ?", current_user).first_or_create
    r.user_id = current_user.id
    r.score = @total_score
    r.save
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
