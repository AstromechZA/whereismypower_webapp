source 'https://rubygems.org'

# explicit ruby version
ruby '2.1.2'

# rails version
gem 'rails', '4.1.4'

# databases
gem 'pg', group: :production
gem 'sqlite3', group: [:development, :test]

# webservers
gem 'unicorn', group: :production
gem 'spring', group: [:development, :test]

# html/javascript/css preprocessors
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '~> 2.5.3'
gem 'coffee-rails', '~> 4.0.1'
gem 'haml-rails', '~> 0.5.3'

# javascript and css includes
gem 'jquery-rails', '~> 3.1.2'

# gems for unittests
group :development, :test do
  gem 'rspec-rails', '~> 3.0.0' # Rspec runs our unit tests
  gem 'simplecov'
  gem 'faker'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'database_cleaner'
end
