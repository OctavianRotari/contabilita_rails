class AddCompanyToFuelReceipt < ActiveRecord::Migration
  def change
    add_reference :fuel_receipts, :company, index: true, foreign_key: true
  end
end
