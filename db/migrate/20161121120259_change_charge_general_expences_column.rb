class ChangeChargeGeneralExpencesColumn < ActiveRecord::Migration
  def change
    rename_column :vehicles, :charge_general_expences, :charge_general_expenses
  end
end
