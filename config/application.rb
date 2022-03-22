require_relative "boot"

require "rails/all"
# require "swe4r"
# require "Ephem"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AstroBlurb
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Zeitwerk auto-loader is having issues on Heroku: `on_file_autoloaded': expected file /app/app/models/pages.rb to define constant Pages
    # Swapping to classic for now: <- this failed, so removing and just obeying Zeitwerk's rules now.
    # config.autoloader = :classic

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
