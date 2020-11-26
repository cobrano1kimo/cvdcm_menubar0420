require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CvdcmMenubar
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.time_zone = 'Asia/Taipei'
    config.active_record.default_timezone= :local
    config.i18n.default_locale = :zh_TW
    config.i18n.fallbacks = [I18n.default_locale]

    # https://stackoverflow.com/questions/30383395/rails-4-jquery-javascript-and-coffee-scripts-not-working
    config.assets.enabled = true
    config.assets.initialize_on_precompile = true

    # 設定 SSL 連線
    # config.force_ssl = true
    # 恢復 port: 80 要清除 Web Browse Cache
  end
end
