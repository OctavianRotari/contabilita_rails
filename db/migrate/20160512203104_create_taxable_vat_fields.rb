class CreateTaxableVatFields < ActiveRecord::Migration
  def change
    create_table :taxable_vat_fields do |t|
      t.decimal :taxable
      t.decimal :vat
      t.belongs_to :invoice, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
