class AddVehicleToFuelReceipt < ActiveRecord::Migration
  def change
    add_reference :fuel_receipts, :vehicle, index: true, foreign_key: true
  end
end
