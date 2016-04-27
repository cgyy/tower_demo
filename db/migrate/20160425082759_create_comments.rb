class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :source_type
      t.integer :source_id
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
