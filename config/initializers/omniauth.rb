OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
      client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},
      scope: 'email,profile,https://www.googleapis.com/auth/drive', #TODO change this to https://www.googleapis.com/auth/drive.file
      access_type: 'offline'
    }
  end