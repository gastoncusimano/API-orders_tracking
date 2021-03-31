class FedexService
	include Singleton
	require 'fedex'

	CREDENTIALS = {
		key: 'VZ0tu2xxC4LKxZY6',
		password: 'AKOh8wjdYsJtNI6CFKaxPFLka',
		account_number: '802388543',
		meter: '100495015',
		mode: 'test'
	} 

	attr_accessor :shipment

	def initialize
		@shipment = Fedex::Shipment.new(CREDENTIALS)
	end

	def track(tracking_number)
		begin
			shipment.track(tracking_number: tracking_number).first
		rescue StandardError => e
			puts e
		end
	end
end
