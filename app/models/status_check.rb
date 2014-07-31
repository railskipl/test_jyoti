class StatusCheck < ActiveRecord::Base
	attr_accessible :user_id, :give_feedback, :give_rating, :self_image, :vote_on_tips, :invite_others
end
