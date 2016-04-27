class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.text :description
      t.integer :project_id
      t.integer :creator_id
      t.integer :updater_id  

      t.timestamps null: false
    end
  end
end
