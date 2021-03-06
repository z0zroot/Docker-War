require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module DockerWar
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Taipei"

    # override ActionView::Base.field_error_proc, ref: http://stackoverflow.com/questions/5267998/rails-3-field-with-errors-wrapper-changes-the-page-appearance-how-to-avoid-t
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.default_locale = "zh-TW"
    config.action_view.embed_authenticity_token_in_remote_forms = true
    config.active_job.queue_adapter = :sidekiq
    config.eager_load_paths += %W(#{config.root}/app/jobs)
    config.assets.precompile += %w(rails_admin/rails_admin.css rails_admin/rails_admin.js *.png *.jpg *.jpeg *.gif)
    config.assets.initialize_on_precompile = false
    config.action_dispatch.session_store = :active_record_store
    config.active_record.raise_in_transactional_callbacks = true
    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false, :fixture_replacement => :factory_girl
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
    Paperclip.options[:command_path] = "/usr/local/bin/identify"
  end
end
