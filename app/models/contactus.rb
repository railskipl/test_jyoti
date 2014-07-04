class Contactus < ActiveRecord::Base
	attr_accessible :email, :message, :name, :subject
	validates_presence_of :email
	validates_presence_of :message, :name, :subject
end
