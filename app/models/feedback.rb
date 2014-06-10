class Feedback < ActiveRecord::Base
	attr_accessible :name, :email, :description
	validates_presence_of :email
end
