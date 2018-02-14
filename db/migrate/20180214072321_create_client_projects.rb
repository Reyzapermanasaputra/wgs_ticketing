class CreateClientProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :client_projects do |t|
      t.integer :client_id
      t.integer :project_id

      t.timestamps
    end
  end
end
