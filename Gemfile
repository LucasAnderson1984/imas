# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.6.4'

gem 'bootsnap', require: false
gem 'bootstrap'
gem 'devise'
gem 'devise_invitable'
gem 'figaro'
gem 'gravatar_image_tag'
gem 'jquery-rails'
gem 'pg'
gem 'puma'
gem 'rails', '~> 6.0.0'
gem 'sassc-rails'
gem 'simple_form'
gem 'uglifier'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'flay'
  gem 'flog'
  gem 'letter_opener'
  gem 'listen'
  gem 'rubocop-rails', require: false
  gem 'scss_lint', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
