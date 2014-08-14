class RatingsController < ApplicationController
 include RatingsHelper
 before_filter :check_user, only: [:new]
  before_filter :authenticate_user!
def index
	
end

def new
 # @q = Rating.where('user_id = ?', current_user.id)
 @rating = Rating.new
end

def reputation_report
  @reputation_and_tip = AccessReputationTip.where('user_id = ?',current_user.id)
  unless @reputation_and_tip.first.intial_reaction_view == true && @reputation_and_tip.first.intial_reputation_view == true
    # Initial case 
    if @reputation_and_tip.first.give_feedback >= 1 && @reputation_and_tip.first.give_ratings >= 1 && @reputation_and_tip.first.vote_on_tips >= 5 && @reputation_and_tip.first.give_selfimage >= 1 && gottips >= 5 && @reputation_and_tip.first.invite_other >= 5 
      #for intial report // setting of logic for onbording sequence
          @reputation_and_tip.first.intial_reputation_view = true
          @reputation_and_tip.first.start_date = Date.today.to_s 
          @reputation_and_tip.first.end_date = (Date.today + 7.days).to_s
          @reputation_and_tip.first.update_attributes(params[:access_reputation_tip])
        ############################################################################### 
          condition_check      
    else
      redirect_to reputation_report_failure_path
    end
  else
    #After initial view of reputation report and tips.
    #This condition will give user to access reputation report and tips for next 7 days.
    @a = Date.today.to_date - (@reputation_and_tip.first.start_date).to_date
    if @a.to_i <= 7
      condition_check
    else
      # This condition used to check last 30 days data for fullfilling the critria to view 
      # reputation reports and tips.
        date_check
        votes_invites_track
        tips_provided
        #####################################################################
        # Tips from 3 diffrent people.
        tips_other 
        ###################################################

      @tip = @praise.count + @criticism.count + @general.count
      if @tip >= 10 && @vote_track.count >= 25 && @track_invites.count >= 3
        #This condition is for to check:
        # 1.User should provide more than 10 tips to other users.
        # 2.Provide 25 vote on tips or more.
        # 3.Send Invites to 3 or more people. 
        if @all_critic >= 3 || @all_praise >= 3 || @all_general >= 3
             # This condition will check for, does user got tips from 3 or more people for last 
             # 30 days.
          condition_check
        else
           redirect_to reputation_report_failure2_path(:case => '2', :id => current_user.id)
        end
      else
        redirect_to reputation_report_failure1_path
      end 
    end  
  end
end

def create
 @q = Rating.where('user_id = ?', current_user.id)
 if @q.empty?
     #for onbording sequence selfimage
     @selfimage = AccessReputationTip.where('user_id = ?', current_user.id)
     a = 1
     if @selfimage
       @selfimage.first.give_selfimage = @selfimage.first.give_selfimage + a
       @selfimage.first.update_attributes(params[:access_reputation_tip])
     end 
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

private
    # Use callbacks to share common setup or constraints between actions.

    def check_user
      if user_signed_in?
      else
        redirect_to root_path, :alert => "Unauthorised Access"
      end
     
    end


end
