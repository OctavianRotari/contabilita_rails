class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :taxable_vat_fields, :vat, :vat_rate
  end
end
