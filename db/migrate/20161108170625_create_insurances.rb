class CreateInsurances < ActiveRecord::Migration
  def change
    create_table :insurances do |t|
      t.datetime :date_of_issue
      t.decimal :total
      t.integer :at_the_expense_of
      t.integer :company_id
      t.string :serial_of_contract
      t.string :description
      t.integer :recurrence
      t.datetime :deadline
      t.timestamps null: true
    end
  end
end
