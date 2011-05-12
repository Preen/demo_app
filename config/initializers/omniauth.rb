Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 'aumsPvYxKl2nQkd1CupEA', 'EncP8Dv1HLyw5WmtbvupsVZc8oDuQ7ucAuQ37Vhs'
    provider :facebook, 'APP_ID', 'APP_SECRET'
    # Mention other providers here you want to allow user to sign in with
end
