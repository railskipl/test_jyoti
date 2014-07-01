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
       flash[:notice] = "Your information has been Sent!." 
       redirect_to home_contactus_path
   else
      flash[:notice] = 'Contact can not be blank!Everything should be field.'
      redirect_to home_contactus_path
end  
end 


end
 