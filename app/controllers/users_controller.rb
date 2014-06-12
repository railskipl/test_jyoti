class UsersController < ApplicationController
  require 'csv'
 before_filter :authenticate_user!
 helper_method :resource, :resource_name, :devise_mapping

 respond_to :html, :js


  def index
	   @users = User.where(:is_admin.exists => false).order("id DESC").paginate(page: params[:page], per_page: 10)

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
  end


  

  def import
    if params[:file].nil?
      redirect_to :back, notice: "Please Attach file" 
    else
      User.import(params[:file],current_user)
      redirect_to invite_paste_users_path, notice: "Users imported."
    end
  end




end
