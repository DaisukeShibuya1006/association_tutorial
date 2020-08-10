Rails.application.config.middleware.use OmniAuth::Builder do
    provider :line, "1654177394", "7fdcb14b64d5978351668072ad344149"
  end