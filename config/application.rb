require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CapetownPower
  class Application < Rails::Application
    config.time_zone = 'Africa/Johannesburg'
    config.active_record.default_timezone = 'Africa/Johannesburg'
  end
end
