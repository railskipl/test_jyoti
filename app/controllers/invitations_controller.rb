class InvitationsController < ApplicationController
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]

  # GET /invitations
  # GET /invitations.json
  def index
    @invitations = Invitation.all
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new

  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
  @invitation = Invitation.new(params[:invitation])
  # random_password = ('0'..'z').to_a.shuffle.first(8).join
  @invitation.sender = current_user
  # @user = User.new(:email => @invitation.recipient_email, :password => random_password,
  #                 :password_confirmation => random_password)
  if !@invitation.recipient_email.blank?
    if @invitation.save
      if signed_in?
        Mailer.invitation(@invitation, @signup_url).deliver
        flash[:success] = "Thank you, invitation sent."
        redirect_to :back
      else
        flash[:success] = "Thank you, we will notify when we are ready."
        redirect_to :back
      end
  else
    # random_password = ('0'..'z').to_a.shuffle.first(8).join
    render :action => 'new'
  end
  else
   flash[:error] = "Something went wrong"
   redirect_to :back
  end  

  
end



  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html { redirect_to @invitation, notice: 'Invitation was successfully updated.' }
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.json
  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:sender_id, :recipient_email, :token, :sent_at, :new,:random_password)
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end     
    end
end
