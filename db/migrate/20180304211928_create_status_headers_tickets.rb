class CreateStatusHeadersTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :status_headers_tickets do |t|
      t.integer :status_header_id
      t.integer :ticket_id

      t.timestamps
    end
  end
end
