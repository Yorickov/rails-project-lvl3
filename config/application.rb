require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv::Railtie.load if %w[development test].include? ENV['RAILS_ENV']

module RailsProjectLvl3
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    config.i18n.available_locales = %i[en]
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml')]

    config.time_zone = 'Europe/Minsk'
    # config.eager_load_paths << Rails.root.join("extras")

    config.generators do |g|
      g.test_framework :test_unit, helper: false
    end
  end
end
