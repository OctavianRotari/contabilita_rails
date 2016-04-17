class AddTaxableToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :taxable, :decimal
  end
end
