class PasteUsersController < ApplicationController
  before_action :set_paste_user, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]
  before_filter :authenticate_user!
  require 'will_paginate/array'
  # GET /paste_users
  # GET /paste_users.json
  def index
    @paste_users = PasteUser.all
    @contacts = Contact.all
  end

  # GET /paste_users/1
  # GET /paste_users/1.json
  def show
  end

  # GET /paste_users/new
  def new
    @paste_user = PasteUser.new
    1.times do
      @paste_user.user_invitations.build
    end
  end

  # GET /paste_users/1/edit
  def edit
  end


  # POST /paste_users
  # POST /paste_users.json
  # def create
  #   @paste_user = PasteUser.new
  #   paste_users = paste_user_params
  #   @paste_users = paste_users[:email].split(",")
  #   @paste_users.delete_if {|i| User.find_by_email(i).present? }

  #      # @emails_txt = @paste_user.email
  #      # @paste_user = @emails_txt.split(/\s*,\s*/)
  
  #     # email = @paste_users.join(',')
  #      # raise paste_users.inspect
  #   @paste_users.each do |email|
  #    random_password = ('0'..'z').to_a.shuffle.first(8).join
  #    @user = User.new(:email => email, :password => random_password,
  #                 :password_confirmation => random_password)
     
  #    p = PasteUser.new(:user_id => current_user.id, :email => email)
  #    p.save
  #     if @user.save
  #       Mailer.paste_user(p,@signup_url, random_password).deliver
  #       # format.html { redirect_to home_dashboard_path, notice: 'Paste user was successfully created.' }
  #       # format.json { render :show, status: :created, location: @paste_user }
  #      else
  #       # random_password = ('0'..'z').to_a.shuffle.first(8).join
  #       # format.html { render :new }
  #       # format.json { render json: @paste_user.errors, status: :unprocessable_entity }
  #     end
  #   end
  #     redirect_to :back
     
  # end



  def create
    @paste_user = PasteUser.new(paste_user_params)
     # raise params.inspect
     respond_to do |format|
      if @paste_user.save
        @paste_user.user_invitations.each do |ui|
           c = Contact.where("email like ? and user_id = ?",ui.email,current_user.id).first_or_create
           if c.email.nil?
            c.email = ui.email
            c.user_id = current_user.id
            c.save
           end
           Mailer.paste_user(ui,@signup_url).deliver
        end
        # 
        format.html { redirect_to  new_paste_user_path, notice: 'Invitation was successfully sent.' }
        format.json { render :show, status: :created, location: @paste_user }
      else
        format.html { render :new }
        format.json { render json: @paste_user.errors, status: :unprocessable_entity }
      end
    end
  end






  # def email_list
  #   departments.collect { |d| d.department_name }.join(', ')
  # end

  # def email_list=(email)
  #   if id && text
  #     emails.destroy_all
  #     email.split(',').each do |d|
  #       paste_user.create(department_name: d.strip.capitalize)
  #     end
  #   end
  # end

 


  # PATCH/PUT /paste_users/1
  # PATCH/PUT /paste_users/1.json
  def update
    respond_to do |format|
      if @paste_user.update(paste_user_params)
        format.html { redirect_to  new_paste_user, notice: 'Paste user was successfully updated.' }
        format.json { render :show, status: :ok, location: @paste_user }
      else
        format.html { render :edit }
        format.json { render json: @paste_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paste_users/1
  # DELETE /paste_users/1.json
  def destroy
    @paste_user.destroy
    respond_to do |format|
      format.html { redirect_to paste_users_url, notice: 'Paste user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def select_contacts
    @contacts = Contact.where("user_id = ? " ,current_user.id)    
  end

  def import_csv
    @contacts = Contact.where("user_id = ? " ,current_user.id).paginate :page => params[:page],:per_page => 10
  end

  def complete
    users = params[:emails]
    if users.nil?
    # @paste_users.each do |email|
     
    #  p = PasteUser.new(:user_id => current_user.id, :email => email)
    
    #   if p.save
    #     Mailer.paste_user(p,@signup_url).deliver
    #     # format.html { redirect_to home_dashboard_path, notice: 'Paste user was successfully created.' }
    #     # format.json { render :show, status: :created, location: @paste_user }
    #    else
    #     # random_password = ('0'..'z').to_a.shuffle.first(8).join
    #     # format.html { render :new }
    #     # format.json { render json: @paste_user.errors, status: :unprocessable_entity }
    #   end
    # end
    redirect_to select_contacts_paste_users_path, :notice => "Please select contacts"
    else
      redirect_to select_contact_invitation_paste_users_path(:emails => users)
    end
  end


  def select_contact_invitation
    @users = params[:emails]
    if request.post?
      paste_user = PasteUser.create(:user_id => current_user.id)
      feedback = params[:feedback].nil? ? 0 : params[:feedback]
      invite = params[:invite].nil? ? 0 : params[:invite]
      users = @users.split
      paste_user ||= []
      users.each do |email|
        u = UserInvitation.create(:paste_user_id => paste_user.id, :user_id => current_user.id,:email => email, 
          :invite_for_feedback => feedback,:invite_for_curiosity => invite )
         Mailer.paste_user(u,@signup_url).deliver
      end
      redirect_to select_contacts_paste_users_url, :notice => "Invitation send successfully"
    end
  end





  def invitation
    @invitations = PasteUser.where("user_id = ?",current_user.id)
  end

  def mirror_me
    
  end

  def my_mirror
   
    @relationships = Relationship.all
  end

  def import_social_contacts
  @contactss = Contact.where("user_id = ? " ,current_user.id)
  @contacts = @contactss.paginate(:page => params[:page],:per_page => 2)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paste_user
      @paste_user = PasteUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paste_user_params
      params.require(:paste_user).permit(:user_id, :name, :email,:circle_id,user_invitations_attributes: [:circle_id,:id,:email,:opinion_value,:invite_for_feedback,:invite_for_curiosity,:paste_user_id,:user_id])
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end     
    end

    
end
