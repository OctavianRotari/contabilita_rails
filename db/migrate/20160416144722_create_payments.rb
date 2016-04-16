class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :total
      t.string :method_of_payment
      t.datetime :date

      t.timestamps null: false
    end
  end
end
