class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :age, :integer, null: false, default: 0
    add_column :users, :address, :integer, null: false, default: 0
    add_column :users, :profile, :text
    add_column :users, :avater, :string
    add_column :users, :favorite_items, :string
    add_column :users, :household, :integer, null: false, default: 0
  end
end
