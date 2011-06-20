Rails.application.config.middleware.use OmniAuth::Builder do
  #lensfinder localhost - provider :facebook, '38101c3675c74542dc2aa810785ebcb8', '5c839e5bb0e858120cf2d7c28ee3030a'
  provider :twitter, 'Qme1kpWx1R9YME00KNdg', 'GgRBzk3t7FBXrrbPChguedeonpepMgsaBhGYc7Je1c'
  provider :facebook, '721e353e65ffa026f7576154ee31300f', 'fa7dbeeeffa5f6220b0db3193947cee5'

end