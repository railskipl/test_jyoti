class ContactsController < ApplicationController
	attr_accessible :email, :message, :name, :subject
end
