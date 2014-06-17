class Circle < ActiveRecord::Base
	attr_accessible :name
	belongs_to :user
	belongs_to :paste_user
	has_many :factors, dependent: :destroy
end
