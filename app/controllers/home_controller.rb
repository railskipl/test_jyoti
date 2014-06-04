class HomeController < ApplicationController
before_filter :authenticate_user!
def dashboard
	@pages = Page.all
end



end
