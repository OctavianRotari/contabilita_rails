class MakeInvoicesPolymorphic < ActiveRecord::Migration
  def self.up
    remove_column :invoices, :total_vat
    remove_column :invoices, :total
    remove_column :invoices, :reason
    remove_column :invoices, :total_taxable
    remove_column :invoices, :type_of_invoice
    add_column :invoices, :content_type, :string
    add_column :invoices, :content_id, :integer
    add_index :invoices, [:content_type, :content_id]
  end

  def self.down
    add_column :invoices, :total_vat, :integer
    add_column :invoices, :total, :integer
    add_column :invoices, :reason, :string
    add_column :invoices, :total_taxable, :integer
    add_column :invoices, :type_of_invoice, :integer
    remove_column :invoices, :content_type
    remove_column :invoices, :content_id
    remove_index :invoices, column: [:content_type, :content_id]
  end
end
