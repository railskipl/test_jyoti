class Tip < ActiveRecord::Base

	 attr_accessible :email, :user_id, :praise,:criticism,:helpful
	 belongs_to :user

	has_many :power_groups

end
