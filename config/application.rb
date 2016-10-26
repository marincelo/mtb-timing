require_relative 'boot'

require 'rails/all'
require 'sprockets/es6'

require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MtbTiming
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.react.camelize_props = true
    config.i18n.default_locale = :hr
  end
end
