source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
# https://stackoverflow.com/questions/23022258/tzinfodatasourcenotfound-error-starting-rails-v4-1-0-server-on-windows
# gem 'tzinfo-data', platforms: [:x64_mingw, :mingw, :mswin]
# Udemy Q&A Bogdan answer
gem 'tzinfo-data', '~> 1.2021', '>= 1.2021.5'

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Add simple forms
# gem 'simple_form'

# Astrology and location gems for accurate birth charting
gem 'swe4r', '0.0.2'  # '~> 0.0.0' (this leads to 0.0.2 being installed which has bad native extensions -> error)
# gem 'eph_jpl'
# gem 'ephemeris'   # Just deciding to use an altered version of this class directly, rather than forking and requiring.
gem 'ruby-ephemeris', '~> 1.1', '>= 1.1.1'
# gem 'zodiac', '~> 0.2.10'
gem 'chinese_zodiac', '~> 0.0.1'
# gem 'countries', '~> 4.2', '>= 4.2.2'
# gem 'country_select', '~> 6.0'
# gem 'country_state_select', '~> 3.1', '>= 3.1.5'
# gem 'cities', '~> 0.3.1'
# gem 'city-state', '~> 0.1.0'
# Hard one to find hosted https://stackoverflow.com/questions/6732931/how-to-require-the-forked-gem-lib-file-name-conflicts
# gem 'effe', :git => 'https://github.com/cdcarter/Effe.git', :require => 'effe'
# gem 'effe', 'master', git: 'https://github.com/cdcarter/Effe'
# gem 'ephem' # my own version I've now gemified. https://github.com/SephQ/Ephem
# gem 'ephem', :git => 'https://github.com/SephQ/Ephem.git' # my own version I've now gemified. https://github.com/SephQ/Ephem


# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  # gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "debug"     # Try this because it's not working with the above
  # gem "byebug"#, platforms: %i[ mri mingw x64_mingw ]      # Let's just try the old byebug then, like the Udemy video

  # Use sqlite3 as a database for Active Record outside of production (Heroku needs Postgres)
  gem "sqlite3", "~> 1.4"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :production do
  gem "pg"
end