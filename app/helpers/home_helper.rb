module HomeHelper
	def signed_in?
     !current_user.nil?
    end
end
