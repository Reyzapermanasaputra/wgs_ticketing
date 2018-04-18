class RemoveCodeFromTickets < ActiveRecord::Migration[5.1]
  def change
    remove_column :tickets, :code
  end
end
