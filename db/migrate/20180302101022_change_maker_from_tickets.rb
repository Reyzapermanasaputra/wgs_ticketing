class ChangeMakerFromTickets < ActiveRecord::Migration[5.1]
  def change
    change_column :tickets, :maker, "integer USING CAST(maker AS integer)"
    change_column :tickets, :receipt, "integer USING CAST(receipt AS integer)"
  end
end
