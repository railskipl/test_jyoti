
require 'digest/sha1'
class Invitation < ActiveRecord::Base

	attr_accessible :recipient_email, :random_password
		belongs_to :sender, :class_name => 'User'
	    has_one :recipient, :class_name => 'User'


		before_create :generate_token
		before_create :decrement_sender_count, :if => :sender
		before_save :random_password


		# def random_password
		#     self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{name}--")
		#     self.crypted_password = encrypt(self.crypted_password)
		#     save(false)
	 #    end

		private

		def recipient_is_not_registered
		  errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
		end

		def sender_has_invitations
		  unless sender.invitation_limit > 0
		    errors.add_to_base 'You have reached your limit of invitations to send.'
		  end
		end

		def generate_token
		  self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
		end

		def decrement_sender_count
		  sender.decrement! :invitation_limit
		end

		def has_password?(submitted_password)
	    random_password == encrypt(submitted_password)
	    end

		# def save_password
  #         (self.crypted_password = password) unless self.crypted_password
  #       end

		

end
