class CreateProgresses < ActiveRecord::Migration[6.1]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :know_how, null: false, foreign_key: true

      t.timestamps
    end

    add_index :progresses, [:user_id, :know_how_id], unique: true
  end
end
