class CreateHeaderTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :header_tickets do |t|
      t.integer :header_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end
