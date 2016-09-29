class CreateActiveInvoices < ActiveRecord::Migration
  def change
    create_table :active_invoices, force: :cascade do |t|
      t.datetime "created_at",      null: true
      t.datetime "updated_at",      null: true
      t.decimal  "total_vat"
      t.decimal  "total"
      t.string   "reason"
      t.decimal  "total_taxable"
    end
  end
end
