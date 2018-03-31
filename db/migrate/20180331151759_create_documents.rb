class CreateDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :documents do |t|
      t.integer :project_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
