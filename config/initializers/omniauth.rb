OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           '538283490345-i7ev0dcehunj8ajj3tgt7mkcdloqcsm7.apps.googleusercontent.com',
           'ZgdnSYBPZ8rOaGvgibLHP47O',
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
