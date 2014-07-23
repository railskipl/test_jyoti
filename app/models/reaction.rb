class Reaction < ActiveRecord::Base
    attr_accessible :reaction_comment, :praise_id, :criticism_id, :general_id, :provider_user_id, :reciver_user_id, :response_id

    belongs_to :praise
    belongs_to :criticism
    belongs_to :general
    belongs_to :user
end
