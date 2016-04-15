class AddVatToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :vat, :decimal
  end
end
