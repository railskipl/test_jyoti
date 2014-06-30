class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	before_filter :authenticate_user!
# Facebook authentication
 def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])
    
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
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
      # flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      # sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to home_dashboard_url
    end
  end

end
