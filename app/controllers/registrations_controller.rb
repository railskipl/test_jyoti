class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
  
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password,:first_name,:last_name,:sex,:zip,:location,:secondary_email,:organization,:industry,:orgsize,:birthday)}
  
end

def after_inactive_sign_up_path_for(resource)
    new_user_session_path
end

def update
  @user = User.find(current_user.id)
      successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end


     
    # Devise use update_with_password instead of update_attributes.
    # This is the only change we make.
    if resource.update_attributes(params[resource_name])
      set_flash_message :notice, :updated
      # Line below required if using Devise >= 1.2.0
      sign_in resource_name, resource, :bypass => true
      if current_user.sign_in_count > 1
        redirect_to root_path 
      else
      redirect_to home_fork_users_path        
      end
      # redirect_to after_update_path_for(resource)
    else
      clean_up_passwords(resource)
      redirect_to root_path # That's the line I need to change
    end
end


  


  private
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name)
  end
 
end


