class AddLitresToFuelReceipts < ActiveRecord::Migration
  def change
    add_column :fuel_receipts, :litres, :integer
  end
end
