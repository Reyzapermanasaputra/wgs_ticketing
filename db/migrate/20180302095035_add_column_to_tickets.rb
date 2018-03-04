class AddColumnToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :category, :string
    add_column :tickets, :prority, :string
    add_column :tickets, :star_date, :date
    add_column :tickets, :end_date, :date
  end
end
