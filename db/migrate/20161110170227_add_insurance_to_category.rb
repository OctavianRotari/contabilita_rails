class AddInsuranceToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :insurance, :boolean
  end
end
