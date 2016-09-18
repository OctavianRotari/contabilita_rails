class AddCategoryIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :category_id, :integer
  end
end
