require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ourayteacherfund
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Mountain Time (US & Canada)'
    # config.eager_load_paths << Rails.root.join("extras")
    config.external_donation_url = 'https://www.google.com/url?q=https%3A%2F%2Fdonate.stripe.com%2F7sI170gAdg6E60o9AA&sa=D&sntz=1&usg=AOvVaw3g8RGc6gGTXpKtUnwor9Tx'
  end
end
