require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MorningbirdApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.assets.paths << Rails.root.join('node_modules')

    ShopifyAPI::Context.setup(
      api_key: Rails.application.credentials.shopify_key,
      api_secret_key: Rails.application.credentials.shopify_secret_key,
      host: 'https://81b3-2a09-bac5-d46d-16dc-00-247-80.ngrok-free.app',
      scope: 'read_orders,read_products',
      is_embedded: true,
      api_version: '2023-10',
      is_private: false
    )
  end
end
