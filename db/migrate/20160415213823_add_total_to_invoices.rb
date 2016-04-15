class AddTotalToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :total, :decimal
  end
end
