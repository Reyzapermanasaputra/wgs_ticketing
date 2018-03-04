class RenameProrityFromTickets < ActiveRecord::Migration[5.1]
  def change
    rename_column :tickets, :prority, :priority
  end
end
