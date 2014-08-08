class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :statuscheck
#Method for trial days for current_user
  def plan_expiry
      @trial_days = TrialDay.first

      @plan_expiry = (current_user.created_at + @trial_days.days.days rescue nil)
      @current_date = (Time.zone.now)
      @remaining_days = (@plan_expiry - @current_date rescue nil).to_i / 1.day 
  end

private
  
  def statuscheck
    @status_check = StatusCheck.where('user_id = ?', current_user.id)[0] rescue nil

    @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
  end

 #Redirect to a specific page on successful sign in
 def after_sign_in_path_for(resource) 
 	if resource.is_admin == true
 		# home_dashboard_path
 		dashboard_index_path
 	else
    if current_user.sign_in_count == 1
      ReputationScore.create(:user_id => current_user.id, :score => 300)
      @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id) rescue nil
      unless @access_reputation_tip.present?
        AccessReputationTip.create(:user_id => current_user.id)
      end
      StatusCheck.create(:user_id => current_user.id)
      edit_user_registration_path
    else
    unless @status_check.present?
      StatusCheck.create(:user_id => current_user.id)
    end

    statuscheck
    if @status_check.give_feedback == false || @status_check.give_rating == false || @status_check.self_image == false || @status_check.vote_on_tips == false || @status_check.invite_others == false
     if @status_check.give_feedback == false
         indiv2_individuals_path
     elsif @status_check.give_rating == false
         indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
         indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
         indiv3_individuals_path
     elsif @status_check.invite_others == false 
         indiv6_individuals_path
     else
         my_mirror_paste_users_path
     end
    else
      @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
         indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
         indiv8_individuals_path
       else
         my_mirror_paste_users_path
       end
    end
     # home_dashboard_path
     
   end

 	end
   
 end

 def after_sign_out_path_for(resource_or_scope)
   # if resource_or_scope.is_admin == false
     sign_out_users_path
  # elsif resource_or_scope.is_admin == true
  #   redirect_to root_path 
  # end
end

def after_update_path_for(resource)
   home_fork_users_path
end
end
