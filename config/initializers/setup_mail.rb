ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "imap.gmail.com",
  :authentication => :login,
  :user_name => "atishkunalinfotech@gmail.com",
  :password => "!@#kunalinfotechkipl"

}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"