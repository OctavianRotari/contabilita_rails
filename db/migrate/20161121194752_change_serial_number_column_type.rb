class ChangeSerialNumberColumnType < ActiveRecord::Migration
  def change
    change_column :invoices, :serial_number, :string
  end
end
