class Criticism < ActiveRecord::Base
	attr_accessible :criticism_comment, :provider_user_id, :email, :tip_accept, :tip_reject, :feedback, :comment_quality, :tip_viewed, :tip_prediction, :typee
end
