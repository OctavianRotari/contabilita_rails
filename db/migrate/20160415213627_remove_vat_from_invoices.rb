class RemoveVatFromInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :vat, :integer
  end
end
