class UsersController < ApplicationController
 before_filter :authenticate_user!
 helper_method :resource, :resource_name, :devise_mapping

 respond_to :html, :js


  def index
	   @users = User.where(:is_admin.exists => false).order("id DESC").paginate(page: params[:page], per_page: 10)
	   @contacts = request.env['omnicontacts.contacts']
       respond_to do |format|
       format.html
     end
  end


  def contact_callback
    @contacts = request.env['omnicontacts.contacts']
    @user = request.env['omnicontacts.user']
    puts "List of contacts of #{user[:name]} obtained from #params[:importer]}:"
    @contacts.each do|contact|puts "Contact found: name => #{contact[:name]}, email => #{contact[:email]}"
    end
  end


  # Method for Invite new User
  def new
  @user = User.new(:invitation_token => params[:invitation_token])
  @user.email = @user.invitation.recipient_email if @user.invitation
  end


end
