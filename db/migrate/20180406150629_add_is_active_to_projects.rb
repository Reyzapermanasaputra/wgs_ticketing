class AddIsActiveToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :is_active, :boolean
  end
end
