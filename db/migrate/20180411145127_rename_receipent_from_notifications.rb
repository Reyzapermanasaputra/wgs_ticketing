class RenameReceipentFromNotifications < ActiveRecord::Migration[5.1]
  def change
    rename_column :notifications, :receipent_id, :recipient_id
  end
end
