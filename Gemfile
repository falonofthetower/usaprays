source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.11'

# Postgresql
gem 'pg'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

group :test, :development do
  gem 'rspec-rails', '2.8.1'
  gem 'capybara', '1.1.2'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'vcr'
  gem 'fakeweb'
end

gem 'aws-s3'

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
gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'refinerycms-justices', :path => 'vendor/extensions'
gem 'refinerycms-executives', :path => 'vendor/extensions'

gem 'rails_12factor', group: :production
