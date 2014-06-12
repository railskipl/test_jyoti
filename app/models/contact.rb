class Contact < ActiveRecord::Base
	attr_accessible :email,:user_id

	validates_uniqueness_of  :email
end
