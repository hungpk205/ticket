require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module BookingTicket
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.available_locales = [:en, :vn]
    config.i18n.default_locale = :vn

    config.to_prepare do
      # Configure single controller layout
      Devise::SessionsController.layout "devises/devise_user"
      Devise::RegistrationsController.layout "devises/devise_user"
      Devise::PasswordsController.layout "devises/devise_user"
    end
  end
end
