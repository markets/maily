Maily.setup do |config|
  # On/off engine
  # config.enabled = !Rails.env.production?

  # Allow templates edition
  # config.allow_edition = !Rails.env.production?

  # Allow deliveries
  # config.allow_delivery = !Rails.env.production?

  # Your application available_locales (or I18n.available_locales) by default
  # config.available_locales = [:en, :es, :pt, :fr]

  # Run maily under different controller ('ActionController::Base' by default)
  # config.base_controller = '::AdminController'

  # Configure hooks path
  # config.hooks_path = 'lib/maily_hooks.rb'

  # Http basic authentication (nil by default)
  # config.http_authorization = { username: 'admin', password: 'secret' }

  # Customize welcome message
  # config.welcome_message = "Welcome to our email testing platform. If you have any problem, please contact support team at support@example.com."
end
