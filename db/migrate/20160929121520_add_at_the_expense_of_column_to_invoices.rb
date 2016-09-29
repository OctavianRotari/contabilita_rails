class AddAtTheExpenseOfColumnToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :at_the_expense_of, :string
  end
end
