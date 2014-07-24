class UserMailer < ActionMailer::Base
  default from: "rubyrails9@gmail.com"

  def email_verification(email)
    @email = email
    mail(:to => email.email,:subject => "Verify your email address!!!")
  end


  
end
