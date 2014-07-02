class Tip < ActiveRecord::Base

	 attr_accessible :email, :user_id, :praise,:criticism,:helpful,:circle_id, :name,:respond_for_tip
	 belongs_to :user

	has_many :power_groups
	belongs_to :circle
	belongs_to :user_invitation

end
