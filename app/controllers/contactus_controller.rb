class ContactusController < ApplicationController

def index
  @contactus = Contactus.all
end

def new
  @contactus = Contactus.new
end

def create
  @contactus = Contactus.new(params[:contactus])
     if @contactus.save
       ContactusMailer.registration_confirmation(@contactus).deliver
       redirect_to home_contactus_path, notice: "Your information has been Sent!."
   else
   	render  :new
end  
end 


end
