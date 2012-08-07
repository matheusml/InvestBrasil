OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '458417717512233', '33c7fa9d386eec0af83d81123a26330f',
  						 {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end
