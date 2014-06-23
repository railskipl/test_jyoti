class Tip < ActiveRecord::Base
	 attr_accessible :email, :user_id, :praise,:criticism,:helpful
	 belongs_to :user
end
