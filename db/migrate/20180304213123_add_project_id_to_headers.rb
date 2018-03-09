class AddProjectIdToHeaders < ActiveRecord::Migration[5.1]
  def change
    add_column :headers, :project_id, :integer
  end
end
