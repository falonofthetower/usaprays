source 'https://rubygems.org'
ruby '2.2.3'

gem 'rails'

# Postgresql
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
  gem 'omniauth-twitter'
end

group :test, :development do
  gem 'rspec-rails', '~> 2.99'
  gem 'capybara', '1.1.2'
  gem 'guard-rspec'
  # gem 'guard-spork'
  gem 'vcr'
  gem 'fakeweb'
  gem 'test-unit', :require => false
  gem 'factory_girl_rails', '~> 4.0'
  gem 'database_cleaner'
  gem 'faker'
end

gem 'aws-s3'
gem 'aws-sdk', '~> 3'

gem 'oauth'

gem 'jquery-rails'

gem 'bootstrap-sass', "~> 2.0.0"

gem "simple_form"

# Content Managment
gem 'refinerycms'
gem 'fog' # Support for using S3 storage

# Used by LeaderFinder
gem 'httparty'

# Used by Leader
gem 'hashie'

# MailChimp library
gem "gibbon"

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'refinerycms-justices', :path => 'vendor/extensions'
gem 'refinerycms-executives', :path => 'vendor/extensions'
gem 'rake', '< 11.0'
gem 'pry-rails', :group => :development

gem 'rails_12factor', group: :production
gem 'savon', '~> 2.11.1'
gem 'figaro'
gem 'excon', '~> 0.50.0'
# gem 'iron_cache_rails'
gem 'redis'
gem 'timecop'
gem 'rubyzip'
gem 'twitter'
# gem 'dalli'

# exceptions
gem 'rollbar'
gem 'oj', '~> 2.12.14'
