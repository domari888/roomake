class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.integer :likes_count, default: 0
      t.integer :marks_count, default: 0
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
