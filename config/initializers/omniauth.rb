OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV['GOOGLE_OAUTH2_CLIENT'],
           ENV['GOOGLE_OAUTH2_KEY'],
           {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
