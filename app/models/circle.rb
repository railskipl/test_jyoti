class Circle < ActiveRecord::Base
	attr_accessible :name
	belongs_to :user
	belongs_to :paste_user
end
