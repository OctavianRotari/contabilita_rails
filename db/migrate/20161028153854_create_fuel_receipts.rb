class CreateFuelReceipts < ActiveRecord::Migration
  def change
    create_table :fuel_receipts do |t|
      t.integer :total
      t.datetime :date_of_issue
      t.timestamps null: false
    end
  end
end
