class ChangeColumnNameCompany < ActiveRecord::Migration
  def change
    rename_column :companies, :category_of_company_id, :category_id
  end
end
