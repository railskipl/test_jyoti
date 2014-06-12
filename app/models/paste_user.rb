class PasteUser < ActiveRecord::Base
	attr_accessible :user_id,:name,:email,:circle_id,:user_invitations_attributes
	belongs_to :user
    has_many :circles
    has_many :user_invitations
   accepts_nested_attributes_for :user_invitations,  allow_destroy: true




 private
	def recipient_is_not_registered
		  errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
	end
end
