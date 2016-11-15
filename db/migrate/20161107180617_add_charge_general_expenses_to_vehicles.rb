class AddChargeGeneralExpensesToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :charge_general_expenses, :boolean, default: false
  end
end
