class CreateStatusHeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :status_headers do |t|
      t.string :status

      t.timestamps
    end
  end
end
