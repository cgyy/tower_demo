class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :user_id
      t.integer :team_id
      t.boolean :admin, default: false
      t.integer :creator_id
      
      t.timestamps null: false
    end
  end
end
