class HomeController < ApplicationController

 before_filter :authenticate_user!, except: [:index,:organization,:individual,:contactus]

def index
  
  @pages= Page.all
	#@page = Page.find(params[:id])
end

def organization
end

def individual
end

def dashboard
    @contacts = request.env['omnicontacts.contacts']
    @con ||= []
    if !@contacts.nil?
	    @contacts.each do |contact|
	       @con << Contact.where(email: contact[:email],user_id: current_user.id ).first_or_create
	    end
	end
    respond_to do |format|
      format.html 
    end

end


def plan
    @plans = Plan.all

end

def contactus
  
end


def history
end

def mspoint
end

def help
end

end
