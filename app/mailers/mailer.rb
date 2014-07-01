class Mailer < ActionMailer::Base
  default from: "rubyrails9@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #

  # def invitation(invitation, signup_url)
  #  recipients =  invitation.recipient_email
  # mail(:subject => 'Invitation', :to => recipients)
  # end


  def invitation(invitation, signup_url)
    @invitation = invitation
    # @random_password = random_password
    mail to:  invitation.recipient_email,
    subject: 'Invite',
    signup_url: 'signup_url'
    invitation.update_attribute(:sent_at, Time.now) 
  end

  def paste_user(ui,signup_url)
    @ui = ui
    mail to:  ui.email,
    subject: 'Invitation',
    signup_url: 'signup_url'
  end

  def prelogin_tips(advice_contact)
     @advice_contact = advice_contact
     mail(:to => @advice_contact.email,:subject => "Tips has been submitted!!!")
  end

  def sponsee_invitation(relationship, signup_url)
    @relationship = relationship
    # @random_password = random_password
    mail to:  relationship.email,
    subject: 'Invite',
    signup_url: 'signup_url'
  end

end
