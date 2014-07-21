class Tip < ActiveRecord::Base

	 attr_accessible :email, :user_id,:response_for_tip, :praise,:criticism,:helpful,:circle_id, :name,:respond_for_tip,:tip_accept,:tip_reject,
	                 :tip_viewed,:tip_prediction,:suggestions,:quality_of_comments,:relationship_id
	 belongs_to :user

	has_many :power_groups
	belongs_to :circle
	belongs_to :user_invitation
	belongs_to :response_tip
	belongs_to :advice_contact

    # validates_presence_of  :praise, :criticism, :helpful
    validates_uniqueness_of :email
    
end
