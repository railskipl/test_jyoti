ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "imap.gmail.com",
  :authentication => :login,
  :user_name => "rubyrails9@gmail.com",
  :password => "kipl123!@#"

}

if Rails.env == "development"
	ActionMailer::Base.default_url_options[:host] = "localhost:3000"
else
	ActionMailer::Base.default_url_options[:host] = "http://m360.herokuapp.com"
end