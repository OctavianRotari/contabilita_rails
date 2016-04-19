class RemovePlateFromInvoice < ActiveRecord::Migration
  def change
    remove_column :invoices, :plate, :string
  end
end
