class AddHeaderIdToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :header_id, :integer
  end
end
