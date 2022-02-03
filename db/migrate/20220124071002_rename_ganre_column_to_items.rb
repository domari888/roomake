class RenameGanreColumnToItems < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :ganre, :genre
  end
end
