class AddPaidToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :paid, :decimal
  end
end
