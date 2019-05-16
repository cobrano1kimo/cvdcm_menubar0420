# config/initializers/locale.rb

# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('lib', 'locales', '*.{rb,yml}')]

# Whitelist locales available for the application
I18n.available_locales = [:zh_TW, :en]

# Set default locale to something other than :en
I18n.default_locale = :zh_TW
