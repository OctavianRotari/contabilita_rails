class AddInsuranceToReceipts < ActiveRecord::Migration
  def change
    add_reference :receipts, :insurance, index: true, foreign_key: true
  end
end
