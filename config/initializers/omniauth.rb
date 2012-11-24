Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "sample key", "sample secret"
end
