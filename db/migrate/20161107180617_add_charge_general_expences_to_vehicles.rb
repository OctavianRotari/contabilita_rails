class AddChargeGeneralExpencesToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :charge_general_expences, :boolean, default: false
  end
end
