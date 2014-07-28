class AccessReputationTip < ActiveRecord::Base
	attr_accessible :user_id, :give_feedback, :vote_on_tips, :invite_other, :give_ratings, :give_selfimage, :got_feedback, 
	                :start_date, :end_date, :intial_reaction_view, :intial_reputation_view
end
