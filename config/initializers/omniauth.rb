Rails.application.config.middleware.use OmniAuth::Builder do
  #local api crediantials

  #config.omniauth :facebook, '276696835845012', '92509aff57114d1880ed8ef664ff30cb'
  #config.omniauth :google_oauth2, '390453749585-98jnem85olk2arqb9cdf8oor86q7p3iv.apps.googleusercontent.com','nglC40-gLAW3sUOrL_iWOPNh'

  # heroku api credintials
  config.omniauth :facebook, '651706351611014', '09bb2b426d1e494af255ad62569a47e9'
  config.omniauth :google_oauth2, '881639063021-cna2s7l4sqot6vh1kf2s735vhi6gbl7d.apps.googleusercontent.com','9CnwRY9v0a1q-xd7civFE9D5'

end



 