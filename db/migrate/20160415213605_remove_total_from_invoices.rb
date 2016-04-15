class RemoveTotalFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :total, :integer
  end
end
