class RenameStarDateToStartDate < ActiveRecord::Migration[5.1]
  def change
    rename_column :tickets, :star_date, :start_date
  end
end
