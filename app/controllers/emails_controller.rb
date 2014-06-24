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
