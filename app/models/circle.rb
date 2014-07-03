class Circle < ActiveRecord::Base
	attr_accessible :name
	belongs_to :user
	belongs_to :paste_user
	has_many :influences
	has_many :power_groups
	has_many :factors, dependent: :destroy
	has_many :relationships
	has_many :sponsers
	has_many :tips
	
end
