class RenameTableFromHeaderTickets < ActiveRecord::Migration[5.1]
  def change
    rename_table :header_tickets, :headers_tickets
  end
end
