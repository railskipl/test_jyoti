class HomeController < ApplicationController

 before_filter :authenticate_user!, except: [:index,:organization,:individual,:contactus,:help,:faq,:term_condition,:privacypolicy,:tip_rating,:dashboard,:learn_more,:how_it_works,:how_it_works_for_my_team,:how_it_works_for_me]

def index
  
  @pages= Page.all
	#@page = Page.find(params[:id])
end

def organization
end

def individual
end

def learn_more
    
end

def fork_users
  
end


def dashboard
    @contacts = request.env['omnicontacts.contacts']
    puts request.env['omniauth']
    @con ||= []
    if !@contacts.nil?
	    @contacts.each do |contact|
	       @con << Contact.where(email: contact[:email],user_id: current_user.id ).first_or_create
	    end
	   redirect_to feedback_relationship_relationships_path ,:notice => "Contacts imported"
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


def faq    
end

def term_condition
end

def privacypolicy
end

def tip_rating    
end

def how_it_works  
end

def how_it_works_for_me  
end

def how_it_works_for_my_team  
end

end
