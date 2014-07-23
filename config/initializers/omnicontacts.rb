require "omnicontacts"
 Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "310713975527-odn49v0ckcrlt2mt7teub2iqnt0s7kgv.apps.googleusercontent.com","ntl2cKHumbHO40qmrv-qTbVa", {:redirect_path => "/users/gmail/contact_callback"}
  importer :facebook, "582691261847606", "12f9e897c0872d8224543ac94b405e42",{:redirect_path =>  "/users/facebook/contact_callback"}
end