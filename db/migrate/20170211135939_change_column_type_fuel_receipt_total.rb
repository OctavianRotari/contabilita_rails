class ChangeColumnTypeFuelReceiptTotal < ActiveRecord::Migration
  def change
    change_column :fuel_receipts, :total, :decimal
  end
end
