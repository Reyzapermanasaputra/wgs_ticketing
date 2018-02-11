class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :username, :string
    add_column :users, :is_active, :boolean
    add_column :users, :contact, :string
    add_column :users, :role_id, :integer
  end
end
