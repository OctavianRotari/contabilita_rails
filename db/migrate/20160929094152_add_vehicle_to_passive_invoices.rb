class AddVehicleToPassiveInvoices < ActiveRecord::Migration
  def change
    add_reference :passive_invoices, :vehicle, index: true, foreign_key: true
  end
end
