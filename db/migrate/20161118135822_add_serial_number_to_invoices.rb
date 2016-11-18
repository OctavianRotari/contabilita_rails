class AddSerialNumberToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :serial_number, :integer
  end
end
