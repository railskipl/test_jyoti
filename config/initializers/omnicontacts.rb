require "omnicontacts"
Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "390453749585-98jnem85olk2arqb9cdf8oor86q7p3iv.apps.googleusercontent.com", "nglC40-gLAW3sUOrL_iWOPNh", {:redirect_path => "http://localhost:3000/users/gmail/contact_callback", :ssl_ca_file => "/etc/ssl/certs/curl-ca-bundle.crt"}
  importer :facebook, "276696835845012", "92509aff57114d1880ed8ef664ff30cb", {:callback_path => "http://localhost:3000"}
end