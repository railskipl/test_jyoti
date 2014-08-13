class UsersController < ApplicationController
  require 'csv'
 before_filter :authenticate_user!,:except => :sign_out
 helper_method :resource, :resource_name, :devise_mapping,:resource_or_scope

 respond_to :html, :js

  

  def index
     @users = User.all
      @emails= Email.where("user_id = ?" ,current_user.id).all

      # @emails= Email.all
       @contacts = request.env['omnicontacts.contacts']
       respond_to do |format|
       format.html
       format.csv { send_data @users.to_csv }
      end
     
  end


# Method for Invite new User
def new
  @user = User.new(:invitation_token => params[:invitation_token])
  @user.email = @user.invitation.recipient_email if @user.invitation
  @user.email = @user.paste_user.email if @user.invitation
  @userinvite = UserInvitation.all    
end


def import
    if params[:file].nil?
      redirect_to :back, notice: "Please Attach file" 
    else
      User.import(params[:file],current_user)
      redirect_to :back, notice: "Users imported."
    end
end



def sign_out
  
end


def toggled_status
   @user = User.find(params[:id])
   @user.status = !@user.status?
    @user.save!
    redirect_to :back 
end

def primary
 @user = User.find(params[:id])
 @secondary_email = current_user.email
 current_user.update_column("email",@user.email)
 @user.email = @secondary_email
 @user.primary = !@email.primary?
 @user.save!
 # raise @email.primary.inspect
 if @user.primary == true 
 end
 redirect_to :back
end

# def complete_profile
#   @user = User.new
#    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :first_name,:last_name,:sex,:location,:city,:secondary_email,:birthday)}
# end

end
