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

#def dashboard
   #  @contacts = request.env['omnicontacts.contacts']
   #  @plans = Plan.all
   #  @trial_days = TrialDay.first
   #  # @user = User.find_by_id(current_user)
   #  @plan_expiry = plan_expiry
   #  @con ||= []
   #  if !@contacts.nil?
	  #   @contacts.each do |contact|
	  #      @con << Contact.where(email: contact[:email],user_id: current_user.id ).first_or_create
	  #   end
	  # end
    # respond_to do |format|
    #   format.html 
    # end



def dashboard
    @contacts = request.env['omnicontacts.contacts']
    @con ||= []
    if !@contacts.nil?
	    @contacts.each do |contact|
	       @con << Contact.where(email: contact[:email],user_id: current_user.id ).first_or_create
	    end
	  end
   redirect_to feedback_relationship_relationships_path ,:notice => "Contacts imported"

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
