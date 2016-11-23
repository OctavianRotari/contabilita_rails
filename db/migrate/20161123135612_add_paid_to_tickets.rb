class AddPaidToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :paid, :boolean
  end
end
