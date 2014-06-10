class PasteUser < ActiveRecord::Base
	attr_accessible :user_id,:name,:email
	belongs_to :user




# def email
#   email.split(/,\s*/).each do |email|
#     TMail::Address.parse(email)
#   end
# rescue TMail::SyntaxError
#   errors.add(:email, "are not valid")
# end

# def email
#   email.split(/,\s*/).each do |email| 
#     unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
#       errors.add(:email, "are invalid due to #{email}")
#     end
#   end
# end



 validates_uniqueness_of :email
#  :format => { :with => /(\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})(,\s*([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,}))*\z)/i },
#          :allow_blank => true



before_validation do

  email = self.email.split(/\s+,\s+/)

  email.each do |email|
    self.errors.add(:emails, "invalid email") unless email=~ /([^\s]+)@([^\s]+)/ 
  end

  self.email = email.join(",")
end



# var paste_user = function(){

#     var err = 0;
#     var userinput1 = $('#email').val();
#     var pattern = /([a-z]+){1}(,\s*[a-z]+)*/i
#     if($('#email').val() != userinput1){
#     $('#email').parent().parent().find('.form-error').html("Please enter Re-type Email same as Email Address");
#     err++;
#     } 
#   };


  # validates_format_of :email, :with => /([a-z]+){1}(,\s*[a-z]+)*/i, :on => :create



 private
	def recipient_is_not_registered
		  errors.add :recipient_email, 'is already registered' if User.find_by_email(recipient_email)
	end
end
