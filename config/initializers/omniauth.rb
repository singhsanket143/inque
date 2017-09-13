OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  # provider :facebook, ENV['1418875898219722'], ENV['e99f986e94dcffd3d5d07caa9a34b8eb']
  provider :facebook, '1418875898219722', 'e99f986e94dcffd3d5d07caa9a34b8eb'
end

