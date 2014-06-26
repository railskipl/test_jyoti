PayPal::SDK.load("config/paypal.yml", Rails.env)
PayPal::SDK.logger = Rails.logger
PayPal::Recurring.configure do |config|
	config.sandbox = true
	config.username = "jyoti.vskp11_api1.gmail.com"
	config.password = "1398338529"
	config.signature = "An5ns1Kso7MWUdW4ErQKJJJ4qi4-A3s4rRQcSE2V4YAwXvBN-uow-.vP"
end 