class RhdStore < ActiveRecord::Base
	attr_accessible :recency ,:history, :diversity, :user_id
	belongs_to :user
end
