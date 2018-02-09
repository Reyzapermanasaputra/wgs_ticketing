class AddIsActiveToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :is_active, :boolean
  end
end
