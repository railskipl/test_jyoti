class ContactsController < ApplicationController
	before_filter :authenticate_user!
end
