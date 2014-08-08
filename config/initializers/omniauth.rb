

  # #For Local machine keys
# OmniAuth.config.logger = Rails.logger
# 
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, "4DchjmlJcaNurvh7BSY1R72IF", "EAwo47aIjDATVckiK764WdlqKyPJAVibIMchxvLAPKMN50XWHw"
#   provider :linkedin, "756az7wsrhkylg", "DkGlBGwnc1HHrgSU"
#   provider :facebook, '276696835845012', '92509aff57114d1880ed8ef664ff30cb'
#   provider :google_oauth2, '152997489713-09adpmf43ojeitsgqbd76m3c29728ubo.apps.googleusercontent.com', 'VObs1FAwhn6U530K_1_XIQmU'
# end
  

# For heroku server keys
OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = "http://m360.herokuapp.com"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1463677190567218','f21b189f3362ed4ca8f9d3d88961449c'
  provider :google_oauth2, '881639063021-cna2s7l4sqot6vh1kf2s735vhi6gbl7d.apps.googleusercontent.com','9CnwRY9v0a1q-xd7civFE9D5'
end
 