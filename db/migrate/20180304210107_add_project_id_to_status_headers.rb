class AddProjectIdToStatusHeaders < ActiveRecord::Migration[5.1]
  def change
    add_column :status_headers, :project_id, :integer
  end
end
