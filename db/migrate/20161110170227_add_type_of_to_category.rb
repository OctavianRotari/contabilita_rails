class AddTypeOfToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :type_of, :integer
  end
end
