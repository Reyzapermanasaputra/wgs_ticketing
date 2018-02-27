class AddTwoFieldToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :maker, :string
    add_column :tickets, :receipt, :string
  end
end
