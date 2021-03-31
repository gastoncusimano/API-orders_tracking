class Shipment < ApplicationRecord
	COURIERS = %w[fedex]

  enum tracking_status: [:created, :on_transit, :delivered, :exception]
  
  validates :courier, :tracking_reference, presence: true
  validates :courier, inclusion: { in: COURIERS }
end