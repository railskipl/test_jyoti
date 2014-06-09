class HomeController < ApplicationController
before_filter :authenticate_user!
def dashboard
    @contacts = request.env['omnicontacts.contacts']
    respond_to do |format|
      format.html 
    end

end

end
