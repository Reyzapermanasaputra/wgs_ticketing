class AddIsArchiveToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :is_archive, :boolean
  end
end
