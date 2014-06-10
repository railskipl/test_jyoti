require "omnicontacts"
 Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "346145848619-a8j01kurgruln2d3gi412f4sndqjbktr.apps.googleusercontent.com","v-u3P65lnQIO4GD9qujYMWzG", {:redirect_path => "/users/gmail/contact_callback"}
  importer :facebook, "482089455256431", "44bc20584648cf3b8d3a1ec0c8798f83",{:redirect_path =>  "#{Rails.root}"}
end