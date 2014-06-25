class Sponsercf < ActiveRecord::Base
	attr_accessible :name,:custom_factor,:user_id
	belongs_to :sponser
	belongs_to :user
	has_many :sponsees
end
