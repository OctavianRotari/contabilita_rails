class CreateCategoryOfCompanies < ActiveRecord::Migration
  def change
    create_table :category_of_companies do |t|
      t.string :category

      t.timestamps null: true
    end
  end
end
