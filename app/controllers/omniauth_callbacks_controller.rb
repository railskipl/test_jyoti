class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	before_filter :authenticate_user!
# Facebook authentication
 def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"],current_user)
    
    if @user.present?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


 # Google authentication
  def google_oauth2
     
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end


# auth = request.env["omniauth.auth"]
#     @current_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)

#     @current_user.track_on_login(request)


#     redirect_to dashboard_url, :notice => "Logged in successfully with #{auth['provider'].capitalize}. Please visit your profile page to set your email."
#   end
# (google_oauth2) Authentication failure! invalid_credentials: OAuth2::Error, {"errors"=>[{"domain"=>"usageLimits", "reason"=>"accessNotConfigured", "message"=>"Access Not Configured. Please use Google Developers Console to activate the API for your project."}], "code"=>403, "message"=>"Access Not Configured. Please use Google Developers Console to activate the API for your project."}: 
# {
#  "error": {
#   "errors": [
#    {
#     "domain": "usageLimits",
#     "reason": "accessNotConfigured",
#     "message": "Access Not Configured. Please use Google Developers Console to activate the API for your project."
#    }
#   ],
#   "code": 403,
#   "message": "Access Not Configured. Please use Google Developers Console to activate the API for your project."
#  }
# }



