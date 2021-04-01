module Couriers
	class FedexCommand < BaseCommand
		def initialize(tracking_number)
			@tracking_number = tracking_number
		end

		def call
			FedexService.instance.track(@tracking_number)
		end
	end
end
