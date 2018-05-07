class AddPathToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :path, :string
  end
end
