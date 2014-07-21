class Contact < ActiveRecord::Base
	attr_accessible :email,:user_id
   	validates :email, :uniqueness => {:scope => :user_id}
    belongs_to :paste_user
    belongs_to :user
end
