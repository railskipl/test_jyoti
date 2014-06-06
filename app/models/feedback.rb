class Feedback < ActiveRecord::Base
	attr_accessible :name, :email, :description
end
