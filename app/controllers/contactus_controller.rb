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
       redirect_to root_path, notice: "Your information has been Sent!."
end  
end 

end
