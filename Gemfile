# frozen_string_literal: true

source 'https://rubygems.org'

gem 'devise',       '~> 4.6.0'
gem 'geocoder',     '~> 1.5'
gem 'high_voltage', '~> 3.1.0'
gem 'jbuilder',     '~> 2.5'
gem 'pg',           '~> 1.1.3'
gem 'puma',         '~> 3.12.0'
gem 'rails',        '5.2.2'
gem 'sass-rails',   '~> 5.0'

gem 'coffee-rails', '~> 4.2'
gem 'uglifier',     '>= 1.3.0'
gem 'webpacker', '~> 3.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'factory_bot_rails', '~> 5.0'

  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.8'
end

group :development do
  gem 'listen',      '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

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
  gem 'sentry-raven'
  gem 'sidekiq', '~> 5.2.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
