require File.expand_path('../boot', __FILE__)

require 'rails/all'

require "i18n/backend/fallbacks"
I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ekran
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Kyiv'
    config.active_record.default_timezone = :local

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:uk, :ru, :en]
    config.i18n.default_locale = :en
    config.i18n.fallbacks = [:en]

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    Rails.application.config.action_mailer.default_url_options = {host: (ENV["#{Rails.env}.host_with_port"] || ENV["#{Rails.env}.host"])}

    config.i18n.load_path += Dir[Rails.root.join("config/locales/**/*.yml").to_s]


    # file_editor
    config.assets.precompile += %w(fonts/octicons/octicons.woff cms/file_editor.css cms/file_editor.js)

  end
end
