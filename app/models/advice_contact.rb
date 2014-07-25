class AdviceContact < ActiveRecord::Base

	include ActiveModel::Validations

	attr_accessible :email, :praise, :criticism, :helpful_tips,:user_id
	has_many :tips
	belongs_to :user
	has_many :ratingothers

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

end
