


Rails.application.config.serve_static_assets = true
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/*"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/fonts"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/javascripts"
Rails.application.config.assets.paths << "#{Rails.root}/vendor/assets/stylesheets"

Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf|otf)\z/
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
