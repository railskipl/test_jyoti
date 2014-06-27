	# PayPal::SDK.load("config/paypal.yml", Rails.env)
	# PayPal::SDK.logger = Rails.logger


	PayPal::SDK.load("config/paypal.yml", Rails.env)
	PayPal::SDK.logger = Rails.logger

	PayPal::Recurring.configure do |config|
	config.sandbox = true
	config.username = "m360_api1.kipl.com"
	config.password = "1403868718"
	config.signature = "AFcWxV21C7fd0v3bYYYRCpSSRl31AyDvC2cpAY12QuyLk9LYsPMZlTS4"
	end


