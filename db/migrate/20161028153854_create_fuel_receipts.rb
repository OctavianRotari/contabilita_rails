class CreateFuelReceipts < ActiveRecord::Migration
  def change
    create_table :fuel_receipts do |t|
      t.integer :total
      t.datetime :date_of_issue
      t.integer  "company_id"
      t.integer  "vehicle_id"
      t.integer  "user_id"
      t.timestamps null: false
    end
  end
end
