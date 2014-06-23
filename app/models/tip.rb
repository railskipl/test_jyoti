class Tip < ActiveRecord::Base
	attr_accessible :praise,:criticism,:helpful_tips
	has_many :power_groups
end
