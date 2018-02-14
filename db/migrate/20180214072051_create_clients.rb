class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact
      t.text :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
