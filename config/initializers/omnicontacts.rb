require "omnicontacts"
 Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "881639063021-cna2s7l4sqot6vh1kf2s735vhi6gbl7d.apps.googleusercontent.com','9CnwRY9v0a1q-xd7civFE9D5", {:redirect_path => "#{Rails.root}"}
  importer :facebook, "482089455256431", "44bc20584648cf3b8d3a1ec0c8798f83",{:redirect_path =>  "#{Rails.root}"}
end