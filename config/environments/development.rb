Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  
  # config.assets.prefix = "/dev-assets"
  

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  
  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = false

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
 
  config.action_mailer.delivery_method = :smtp

        config.action_mailer.smtp_settings = {
            :enable_starttls_auto => true,
            :address => "smtp.gmail.com",
            :port => 587,
            :domain => "imap.gmail.com",
            :authentication => :login,
            :user_name => "atishkunalinfotech@gmail.com",
            :password => "!@#kunalinfotechkipl"
        }
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }


  config.after_initialize do
    ActiveMerchant::Billing::Base.mode = :test
    paypal_options = {
      :login => "m360_api1.kipl.com",
      :password => "1403868718",
      :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AyDvC2cpAY12QuyLk9LYsPMZlTS4",
    }
    ::STANDARD_GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(paypal_options)
    ::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
  end
end
