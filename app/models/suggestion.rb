class Suggestion < ActiveRecord::Base
	attr_accessible :feedback_comment, :praise_id, :criticism_id, :general_id, :provider_user_id, :recipient_email, :comment_quality

	belongs_to :praise
	belongs_to :criticism
	belongs_to :general
	belongs_to :user
end
