class AccessReputationTip < ActiveRecord::Base
	attr_accessible :user_id, :give_feedback, :vote_on_tips, :invite_other, :give_ratings, :give_selfimage, :got_feedback
end
