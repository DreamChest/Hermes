require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Hermes
  # Main app class
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # Create favicon dir if needed
    config.after_initialize do
      FileUtils.mkdir_p(FAVICON_BASE_DIR) unless File.exist?(FAVICON_BASE_DIR)
    end

    # Cors support
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options]
      end
    end
  end

  # App version numbers
  APP_VERSION = `git describe --tags --abbrev=0`.squish || 'unknown'
  API_VERSION = '1'.freeze

  ## Favicons constants
  FAVICON_TEMP_PATH = Rails.root.join('tmp/favicon.ico').freeze
  FAVICON_BASE_URL = '/assets/favicons'.freeze
  FAVICON_BASE_DIR = Rails.root.join("public/#{FAVICON_BASE_URL}").freeze
end
