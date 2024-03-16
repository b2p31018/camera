require_relative 'boot'
require 'rails/all'
require 'dotenv/load'

Bundler.require(*Rails.groups)

module AttendanceApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.active_support.cache_format_version = 7.0
    config.time_zone = 'Asia/Tokyo'
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
  end
end

# LINE_CHANNEL_ACCESS_TOKEN を .env ファイルからロード
LINE_CHANNEL_TOKEN = ENV['LINE_CHANNEL_TOKEN']
LINE_CHANNEL_SECRET = ENV['LINE_CHANNEL_SECRET']
LINE_USER_ID = ENV['LINE_USER_ID']
