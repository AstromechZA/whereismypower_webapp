Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.assets.js_compressor = :uglifier

  config.assets.compile = true

  config.assets.digest = true

  config.log_level = :info

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  config.active_record.dump_schema_after_migration = false
end
