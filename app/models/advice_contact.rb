class AdviceContact < ActiveRecord::Base
	attr_accessible :email, :praise, :criticism, :helpful_tips,:user_id
	validates_presence_of :praise,:criticism,:helpful_tips
	has_many :tips
	belongs_to :user
	has_many :ratingothers
end
