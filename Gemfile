source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.2"
# gem 'rails', github: 'rails/rails', branch: 'main'

gem "acts_as_list"
gem "aws-sdk-s3"
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "friendly_id"
gem "good_job"
gem "heroicon"
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem "kredis"
gem "pagy"
gem "pg", "~> 1.4.5"
gem "propshaft", "~> 0.7.0"
gem "puma", "~> 6.0"
gem "rails", "~> 8.0.2"
gem "redis", "~> 5.0"
gem "sorcery"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 3.3.0"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "hotwire-spark"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "annotate"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end
