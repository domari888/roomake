class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :ganre
      t.string :image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
