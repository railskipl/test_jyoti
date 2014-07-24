class Response < ActiveRecord::Base
	attr_accessible :response_comment, :praise_id, :criticism_id, :general_id, :response_user_id, :provider_user_id

    belongs_to :praise
    belongs_to :criticism
    belongs_to :general
    belongs_to :user

end
