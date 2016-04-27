class CreateAccesses < ActiveRecord::Migration
  def change
    create_table :accesses do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :admin, default: false
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
