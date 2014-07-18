class AdviceContact < ActiveRecord::Base
	attr_accessible :email, :praise, :criticism, :helpful_tips,:user_id
	has_many :tips
	belongs_to :user
	has_many :ratingothers

	
end
