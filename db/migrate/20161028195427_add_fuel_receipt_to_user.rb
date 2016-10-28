class AddFuelReceiptToUser < ActiveRecord::Migration
  def change
    add_reference :users, :fuel_receipt, index: true, foreign_key: true
  end
end
