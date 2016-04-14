class CreateClientsAndSuppliers < ActiveRecord::Migration
  def change
    create_table :clients_and_suppliers do |t|
      t.string :name
      t.string :adress
      t.integer :number

      t.timestamps null: false
    end
  end
end
