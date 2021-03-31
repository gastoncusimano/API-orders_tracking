class CreateShipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shipments do |t|
      t.string :courier, null: false
      t.string :tracking_reference, null: false
      t.string :tracking_status, null: false, default: 'created'
      
      t.timestamps
    end
  end
end
