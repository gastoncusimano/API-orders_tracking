class Shipment < ApplicationRecord
	COURIERS = %w[fedex]

  enum tracking_status: {
    created: 'created',
    on_transit: 'on_transit',
    delivered: 'delivered',
    exception: 'exception'
  }
  
  validates :courier, :tracking_reference, presence: true
  validates :courier, inclusion: { in: COURIERS }
end