class AddClientsAndSupplierToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :clients_and_supplier, index: true, foreign_key: true
  end
end
