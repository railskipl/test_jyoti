class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#Method for trial days for current_user
  def plan_expiry
      @trial_days = TrialDay.first
      @plan_expiry = (current_user.created_at + @trial_days.days)
      @current_date = (Time.zone.now)
      @remaining_days = (@plan_expiry - @current_date).to_i / 1.day
  end

private

 #Redirect to a specific page on successful sign in
 def after_sign_in_path_for(resource) 
 	if resource.is_admin == true
 		# home_dashboard_path
 		dashboard_index_path
 	else
     # home_dashboard_path
     my_mirror_paste_users_path
 	end
   
 end



end
