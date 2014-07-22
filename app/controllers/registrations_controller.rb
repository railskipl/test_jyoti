class RegistrationsController < Devise::RegistrationsController

  before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password,:first_name,:last_name,:sex,:zip,:location,:secondary_email,:organization,:industry,:orgsize,:birthday)}
end

def after_inactive_sign_up_path_for(resource)
    new_user_session_path
end
 
end


