class AddGasStationToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :gas_station, :boolean
  end
end
