class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.text :description
      t.integer :assignee_id
      t.date :due_date
      t.integer :finisher_id
      t.datetime :finished_at
      t.integer :project_id
      t.integer :list_id

      t.integer :creator_id
      t.integer :updater_id
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
