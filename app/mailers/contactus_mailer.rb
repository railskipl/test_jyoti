class ContactusMailer < ActionMailer::Base
    default from: "rubyrails9@gmail.com"

  def registration_confirmation(contactus)
      @contactus = contactus
      mail(:to => contactus.email, :subject => "Thank you for contacting us!.")
  end
end
