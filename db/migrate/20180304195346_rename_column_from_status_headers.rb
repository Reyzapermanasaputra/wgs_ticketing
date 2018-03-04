class RenameColumnFromStatusHeaders < ActiveRecord::Migration[5.1]
  def change
    rename_column :status_headers, :status, :name
  end
end
