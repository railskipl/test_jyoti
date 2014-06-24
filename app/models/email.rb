class Email < ActiveRecord::Base
	include Tokenable
	attr_accessible :email, :user_id, :token,:verified, :merged,:primary
	belongs_to :user
end
