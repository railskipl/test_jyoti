class Contactus < ActiveRecord::Base
	attr_accessible :email, :message, :name, :subject
	validates_presence_of :email,:message
end