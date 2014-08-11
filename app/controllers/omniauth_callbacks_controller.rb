class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	before_filter :authenticate_user!
# Facebook authentication
 def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"],current_user)
    
    if @user.present?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      check_db
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      check_db
      redirect_to new_user_registration_url
    end
  end


 # Google authentication
#   def google_oauth2
#     @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
 
#     if @user.persisted?
#       flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
#       check_db
#       sign_in_and_redirect @user, :event => :authentication
#     else
#       session["devise.google_data"] = request.env["omniauth.auth"]
#       check_db
#       redirect_to new_user_registration_url
#     end
#   end
# end



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
      redirect_to new_user_registration_url
    end
  end
end


def check_db
  @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id) rescue nil
  @status_check = StatusCheck.where('user_id = ?', current_user.id)[0] rescue nil
  unless @access_reputation_tip.present?
    AccessReputationTip.create(:user_id => current_user.id) rescue nil
  end
  unless @status_check.present?
    StatusCheck.create(:user_id => current_user.id) rescue nil
  end
end