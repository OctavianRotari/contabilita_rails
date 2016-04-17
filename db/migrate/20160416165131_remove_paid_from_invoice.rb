class RemovePaidFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :paid, :decimal
  end
end
