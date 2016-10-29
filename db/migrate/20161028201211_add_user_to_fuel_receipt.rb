class AddUserToFuelReceipt < ActiveRecord::Migration
  def change
    add_reference :fuel_receipts, :user, index: true, foreign_key: true
  end
end
