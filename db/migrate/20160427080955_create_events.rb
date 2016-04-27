class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :team_id
      t.integer :project_id
      t.integer :user_id
      t.string  :source_type
      t.integer :source_id
      t.string :behaviour
      t.string :message

      t.timestamps null: false
    end
  end
end
