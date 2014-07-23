class General < ActiveRecord::Base
	attr_accessible :general_comment, :provider_user_id, :email, :tip_accept, :tip_reject, :feedback, :comment_quality, :tip_viewed, :tip_prediction, :typee, :circle_name
    
    has_many :suggestions
    belongs_to :user
end
