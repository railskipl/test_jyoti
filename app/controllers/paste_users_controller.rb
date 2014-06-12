class PasteUsersController < ApplicationController
  before_action :set_paste_user, only: [:show, :edit, :update, :destroy]

  # GET /paste_users
  # GET /paste_users.json
  def index
    @paste_users = PasteUser.all
  end

  # GET /paste_users/1
  # GET /paste_users/1.json
  def show
  end

  # GET /paste_users/new
  def new
    @paste_user = PasteUser.new
  end

  # GET /paste_users/1/edit
  def edit
  end


  # POST /paste_users
  # POST /paste_users.json
  def create
    @paste_user = PasteUser.new
    paste_users = paste_user_params
    @paste_users = paste_users[:email].split(",")
    @paste_users.delete_if {|i| User.find_by_email(i).present? }

       # @emails_txt = @paste_user.email
       # @paste_user = @emails_txt.split(/\s*,\s*/)
  
      # email = @paste_users.join(',')
       # raise paste_users.inspect
    @paste_users.each do |email|
     random_password = ('0'..'z').to_a.shuffle.first(8).join
     @user = User.new(:email => email, :password => random_password,
                  :password_confirmation => random_password)
     
     p = PasteUser.new(:user_id => current_user.id, :email => email)
     p.save
      if @user.save
        Mailer.paste_user(p,@signup_url, random_password).deliver
        # format.html { redirect_to home_dashboard_path, notice: 'Paste user was successfully created.' }
        # format.json { render :show, status: :created, location: @paste_user }
       else
        # random_password = ('0'..'z').to_a.shuffle.first(8).join
        # format.html { render :new }
        # format.json { render json: @paste_user.errors, status: :unprocessable_entity }
      end
    end
      redirect_to :back
     
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
        format.html { redirect_to @paste_user, notice: 'Paste user was successfully updated.' }
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

  def complete
    @paste_users = params[:paste_users][:paste_user_emails]
    
    @paste_users.each do |email|
     random_password = ('0'..'z').to_a.shuffle.first(8).join
     @user = User.new(:email => email, :password => random_password,
                  :password_confirmation => random_password)
     
     p = PasteUser.new(:user_id => current_user.id, :email => email)
     p.save
      if @user.save
        Mailer.paste_user(p,@signup_url, random_password).deliver
        # format.html { redirect_to home_dashboard_path, notice: 'Paste user was successfully created.' }
        # format.json { render :show, status: :created, location: @paste_user }
       else
        # random_password = ('0'..'z').to_a.shuffle.first(8).join
        # format.html { render :new }
        # format.json { render json: @paste_user.errors, status: :unprocessable_entity }
      end
    end
      redirect_to :back
    
  end

  def invitation
    @invitations = PasteUser.where("user_id = ?",current_user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paste_user
      @paste_user = PasteUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def paste_user_params
      params.require(:paste_user).permit(:user_id, :name, :email)
    end
end
