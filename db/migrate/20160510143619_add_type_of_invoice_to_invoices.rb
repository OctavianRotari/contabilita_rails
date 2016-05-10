class AddTypeOfInvoiceToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :type_of_invoice, :string
  end
end
