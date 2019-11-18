class AddUniqueToColumn < ActiveRecord::Migration[5.2]
  def change
    add_index :publishers, :name, unique: true
    add_index :books, :isbn, unique: true
    add_index :authors, :name, unique: true
  end
end
