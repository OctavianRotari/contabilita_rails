class AddCategoryToInsurances < ActiveRecord::Migration
  def change
    add_reference :insurances, :category, index: true
  end
end
