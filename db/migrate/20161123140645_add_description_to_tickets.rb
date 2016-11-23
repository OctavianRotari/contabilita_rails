class AddDescriptionToTickets < ActiveRecord::Migration
  def change
    remove_column :tickets, :description, :string
    add_column :tickets, :description, :string
  end
end
