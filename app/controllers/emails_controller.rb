class EmailsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :check_user, only: [:new,:verify,:merge]

def new
	@email= Email.new
end

def create
 emails = params[:email][:email].split(",")
    @errors = Array.new
    emails.each do |email|
      @email = Email.new(:email => email,:verified => false,:user_id => current_user.id)
      if @email.save
        UserMailer.email_verification(@email).deliver
      else
        @errors << "#{email} : #{@email.errors.full_messages.join(",")}"
      end
    end
    if @errors.empty?
      redirect_to :back,:notice => "Email(s) save Successfully"
    else
      redirect_to :back,:alert =>"Following Emails rejected: <br/> #{@errors.join("<br/>")}"
    end
  end


def verify
   @email=Email.find_by_token_and_verified_and_email(params[:identity],false,params[:email])
   @email.verified = !@email.verified?
    @email.save!
    redirect_to root_path
end


def merge
    @email = Email.find(params[:id])
    @email.merged = !@email.merged?
    @email.save!
    redirect_to :back
end


def primary
 @email = Email.find(params[:id])
 @secondary_email = current_user.email
 current_user.update_column("email",@email.email)
 @email.email = @secondary_email
 @email.primary = !@email.primary?
 @email.save!
 # raise @email.primary.inspect
 unless @email.primary == true 
  if @email.merged == true
    
    # raise @email.email.inspect
    @tip = Tip.where("user_id = ?",current_user.id)
     # raise @tip.inspect
  end
 end
 redirect_to :back
end




private
    # Use callbacks to share common setup or constraints between actions.

    def check_user
      if user_signed_in?
      else
        redirect_to root_path, :alert => "Unauthorised Access"
      end
     
    end
	
end
