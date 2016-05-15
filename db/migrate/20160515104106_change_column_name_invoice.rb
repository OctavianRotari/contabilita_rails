class ChangeColumnNameInvoice < ActiveRecord::Migration
  def change
    rename_column :invoices, :vat, :total_vat
    rename_column :invoices, :taxable, :total_taxable
  end
end
