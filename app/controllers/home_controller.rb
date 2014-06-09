class HomeController < ApplicationController



def index
end

def dashboard
    @contacts = request.env['omnicontacts.contacts']
    respond_to do |format|
      format.html 
    end

end

end
