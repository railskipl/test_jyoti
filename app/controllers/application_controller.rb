class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#Method for trial days for current_user
  def plan_expiry
      @trial_days = TrialDay.first

      @plan_expiry = (current_user.created_at + @trial_days.days.days rescue nil)
      @current_date = (Time.zone.now)
      @remaining_days = (@plan_expiry - @current_date rescue nil).to_i / 1.day 
  end

private

 #Redirect to a specific page on successful sign in
 def after_sign_in_path_for(resource) 
 	if resource.is_admin == true
 		# home_dashboard_path
 		dashboard_index_path
 	else
    if current_user.sign_in_count == 1
      ReputationScore.create(:user_id => current_user.id, :score => 300)
      edit_user_registration_path(current_user)
    else
     # home_dashboard_path
     my_mirror_paste_users_path
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
