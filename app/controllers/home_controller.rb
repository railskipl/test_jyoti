class HomeController < ApplicationController



def index
	#@pages= Page.all
	#@page = Page.find(params[:id])
end

def dashboard
    @contacts = request.env['omnicontacts.contacts']
    respond_to do |format|
      format.html 
    end

end

end
