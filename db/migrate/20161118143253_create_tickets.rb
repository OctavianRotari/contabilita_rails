class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer, :total
      t.datetime, :date_of_issue
      t.datetime, :deadline
      t.referece :user_id

      t.timestamps null: false
    end
  end
end
