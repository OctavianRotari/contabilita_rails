class AddReasonToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :reason, :string
  end
end
