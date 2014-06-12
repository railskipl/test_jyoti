class UserInvitation < ActiveRecord::Base
	attr_accessible :user_id,:email,:opinion_value,:invite_for_feedback,:invite_for_curiosity,:circle,:circle_id,:paste_user_id
	belongs_to :paste_user
	validates_uniqueness_of :email
	validates_presence_of   :email

end
