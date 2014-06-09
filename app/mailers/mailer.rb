class Mailer < ActionMailer::Base
  default from: "priya@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #

  # def invitation(invitation, signup_url)
  #  recipients =  invitation.recipient_email
  # mail(:subject => 'Invitation', :to => recipients)
  # end


def invitation(invitation, signup_url,random_password)
  @invitation = invitation
  @random_password = random_password
  mail to:  invitation.recipient_email,
  subject: 'Invite',
  signup_url: 'signup_url'
  invitation.update_attribute(:sent_at, Time.now) 
end
end
