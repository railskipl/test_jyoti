class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private

 #Redirect to a specific page on successful sign in
 def after_sign_in_path_for(resource) 
 	if resource.is_admin == true
 		# home_dashboard_path
 		dashboard_index_path
 	else
     home_dashboard_path
 	end
   
 end



end
