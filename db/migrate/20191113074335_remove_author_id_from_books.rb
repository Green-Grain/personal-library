class RemoveAuthorIdFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :author_id, foreign_key: true
  end
end
