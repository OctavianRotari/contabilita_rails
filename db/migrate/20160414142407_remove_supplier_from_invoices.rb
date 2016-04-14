class RemoveSupplierFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :supplier, :string
  end
end
