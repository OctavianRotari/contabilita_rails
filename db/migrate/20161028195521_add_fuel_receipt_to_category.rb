class AddFuelReceiptToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :fuel_receipt, index: true, foreign_key: true
  end
end
