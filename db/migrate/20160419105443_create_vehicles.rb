class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :plate
      t.string :type_of_vehicle

      t.timestamps null: true
    end
  end
end
