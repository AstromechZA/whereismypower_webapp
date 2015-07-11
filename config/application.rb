require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CapetownPower
  class Application < Rails::Application
    config.time_zone = 'Africa/Johannesburg'

    unless Rails.env.test?
      log_level = String(ENV['LOG_LEVEL'] || 'info').upcase
      config.logger = (Rails.env.development? ? Logger.new('/dev/null') : Logger.new(STDOUT))
      config.logger.level = Logger.const_get(log_level)
      config.log_level = log_level
    end
  end
end
