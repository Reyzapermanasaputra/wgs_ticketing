class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :code
      t.string :title
      t.text :description
      t.string :status

      t.timestamps
    end
  end
end
