class SessionsController < Devise::SessionsController

 respond_to :html, :js
 
  # def new
  #   super
  # end

  # def create
  #   self.resource = warden.authenticate!(auth_options)
  #     if resource.status # Check the users status(true or false) whether suspended or not?
  #     	sign_out current_user 
  #       redirect_to root_url,:notice => "Your account is Suspended please contact admin"
  #     else
  #       set_flash_message(:notice, :signed_in) if is_navigational_format?
  # 	    sign_in(resource_name, resource)
  # 	    if !session[:return_to].blank?
  # 	      redirect_to session[:return_to]
  # 	      session[:return_to] = nil
  # 	    else
  # 	      respond_with resource, :location => after_sign_in_path_for(resource)
  # 	    end
  #     end
  # end

end
