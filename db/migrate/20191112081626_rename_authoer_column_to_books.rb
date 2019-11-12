class RenameAuthoerColumnToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :authoer_id, :author_id
  end
end
