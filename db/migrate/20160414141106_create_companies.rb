class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :adress
      t.string :number

      t.timestamps null: true
    end
  end
end
