OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '647978612152-74im8h6ello19fjh4dpkl9i74v662l73.apps.googleusercontent.com', '2Bhu_CeeFKSn5VHHgbyBU75n'
end