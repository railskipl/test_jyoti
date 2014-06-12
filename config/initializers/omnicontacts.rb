require "omnicontacts"
 Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "310713975527-odn49v0ckcrlt2mt7teub2iqnt0s7kgv.apps.googleusercontent.com","ntl2cKHumbHO40qmrv-qTbVa", {:redirect_path => "/users/gmail/contact_callback"}
  importer :facebook, "482089455256431", "44bc20584648cf3b8d3a1ec0c8798f83",{:redirect_path =>  "#{Rails.root}"}
end