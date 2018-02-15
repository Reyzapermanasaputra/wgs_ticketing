class AddProjectIdToClients < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :project_id, :integer
  end
end
