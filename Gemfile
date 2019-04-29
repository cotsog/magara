# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~> 2.5'

gem 'devise',       '~> 4.6.0'
gem 'geocoder',     '~> 1.5'
gem 'pg',           '~> 1.1.3'
gem 'puma',         '~> 3.12.0'
gem 'rails',        '~> 6.0.0.rc1'
gem 'sass-rails',   '~> 5.0'
gem 'searchkick',   '~> 3.1'

gem 'coffee-rails', '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'webpacker',    '~> 4.0'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot_rails', '~> 5.0'

  gem 'rspec-core', git: 'https://github.com/rspec/rspec-core'
  gem 'rspec-expectations', git: 'https://github.com/rspec/rspec-expectations'
  gem 'rspec-mocks', git: 'https://github.com/rspec/rspec-mocks'
  gem 'rspec-rails', git: 'https://github.com/rspec/rspec-rails', branch: '4-0-dev'
  gem 'rspec-support', git: 'https://github.com/rspec/rspec-support'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', git: 'https://github.com/rails/web-console'

  gem 'brakeman', '~> 4.4', require: false

  gem 'rubocop', '~> 0.58', require: false
  gem 'rubocop-rspec'

  gem 'scss_lint', '~> 0.57.0', require: false
end

group :test do
  gem 'faker', '>= 1.9.1'

  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :production do
  # ActiveStorage requires S3
  gem 'aws-sdk-s3', require: false

  # Deliver emails with Mailgun API instead of default SMTP
  gem 'mailgun-ruby', '~> 1.1'

  gem 'sentry-raven'
  gem 'sidekiq', '~> 5.2.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
