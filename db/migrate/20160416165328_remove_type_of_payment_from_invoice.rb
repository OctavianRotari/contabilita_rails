class RemoveTypeOfPaymentFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :type_of_payment, :string
  end
end
