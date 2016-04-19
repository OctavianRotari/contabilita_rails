class AddVehicleToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :vehicle, index: true, foreign_key: true
  end
end
