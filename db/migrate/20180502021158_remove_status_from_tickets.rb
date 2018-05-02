class RemoveStatusFromTickets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tickets, :status
  end
end
