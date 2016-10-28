class AddFuelReceiptToCompany < ActiveRecord::Migration
  def change
    add_reference :companies, :fuel_receipt, index: true, foreign_key: true
  end
end
