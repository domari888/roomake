class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|
      t.string :title, null: false
      t.string :subtitle, null: false
      t.string :image, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
