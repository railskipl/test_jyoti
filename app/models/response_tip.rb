class ResponseTip < ActiveRecord::Base
	attr_accessible :tip_id, :response_for_tip, :tag_tip, :user_id
	has_many :tips
end
