namespace :shipments do
  desc 'Synchronize all the shipments in the system'
  # You should add tasks for new couriers

  # Fedex CODES
  ON_TRANSIT_FEDEX_CODE = %w[DP CD AP AR FD SF CC IT HL OD PU]
  DELIVERED_FEDEX_CODE = %w[DL]
  EXCEPTION_FEDEX_CODE = %w[DE CA SE]

  task :synchronize_fedex => :environment do
    Shipment.fedex.each do |shipment|
      puts "Checking Fedex shipment number: #{shipment.tracking_reference}"
      if shipment.courier == 'fedex'
        result = Couriers::FedexCommand.call(shipment.tracking_reference)
      else
        puts 'Courier invalid name, check your data (maybe misspelled)'
      end
      if result.present?
        puts result.status_code.inspect
        puts result.status.inspect
        if ON_TRANSIT_FEDEX_CODE.include?(result.status_code)
          shipment.on_transit!
        elsif DELIVERED_FEDEX_CODE.include?(result.status_code)
          shipment.delivered!
        elsif EXCEPTION_FEDEX_CODE.include?(result.status_code)
          shipment.exception!
        else 
          shipment.created!
        end
      else 
        puts 'An error has ocurred on your synchronization, we are going to retry the request in an hour'
      end
    end
  end
end
