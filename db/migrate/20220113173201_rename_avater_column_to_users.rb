class RenameAvaterColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :avater, :avatar
  end
end
