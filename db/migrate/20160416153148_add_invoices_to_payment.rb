class AddInvoicesToPayment < ActiveRecord::Migration
  def change
    add_reference :payments, :invoice, index: true, foreign_key: true
  end
end
