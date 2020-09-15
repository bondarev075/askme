#reCAPTCHA cofig
Recaptcha.configure do |config|
  config.site_key = ENV['RECAPTCHA_V2_GOODQA_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_V2_GOODQA_PRIVATE_KEY']
end
