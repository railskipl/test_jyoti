module InvitationsHelper
	def signed_in?
     !current_user.nil?
    end

    def random_password
		    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{name}--")
		    self.crypted_password = encrypt(self.crypted_password)
		    save(false)
	end
end
