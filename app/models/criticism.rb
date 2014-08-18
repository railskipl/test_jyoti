class Criticism < ActiveRecord::Base
	attr_accessible :criticism_comment, :provider_user_id, :email, :tip_accept, :tip_reject, :feedback, :comment_quality, :tip_viewed, :tip_prediction, :typee, :circle_name, :status, :city
    
    has_many :suggestions
    has_many :responses
    has_many :reactions
    
    belongs_to :user
end
