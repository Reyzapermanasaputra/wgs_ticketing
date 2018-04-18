class RenameColumnFromTickets < ActiveRecord::Migration[5.1]
  def change
    rename_column :tickets, :receipt, :recipient_id
    rename_column :tickets, :maker, :maker_id
  end
end
