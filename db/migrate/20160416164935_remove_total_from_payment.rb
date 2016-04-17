class RemoveTotalFromPayment < ActiveRecord::Migration
  def change
    remove_column :payments, :total, :decimal
  end
end
