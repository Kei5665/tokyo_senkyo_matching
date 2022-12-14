require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.generators do |g|
      g.skip_routes true # ルーティングを追加しない
      g.assets false # アセットファイルを生成しない
      g.helper false # ヘルパーファイルを生成しない
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false
    end
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
