class AddVehicleToInsurance < ActiveRecord::Migration
  def change
    add_reference :insurances, :vehicle, index: true, foreign_key: true
  end
end
