module Shipments
	class CreateCommand < BaseCommand
		attr_reader :courier, :tracking_reference

		def initialize(params)
			@courier = params[:courier]
			@tracking_reference = params[:tracking_reference]
		end

		def call
			find_shipment ({courier: courier, tracking_reference: tracking_reference})
		end

		private
		def find_shipment shipment_params
			shipment = Shipment.find_by(shipment_params)
			if shipment.present?
				OpenStruct.new(response: shipment, errors: nil)
			else
				create_shipment(shipment_params)
			end
		end

		def create_shipment shipment_params
			shipment = Shipment.new(shipment_params)
			if shipment.save
				OpenStruct.new(response: shipment, errors: nil)
			else
				OpenStruct.new(response: nil, errors: shipment.errors.full_messages)
			end
		end
	end
end