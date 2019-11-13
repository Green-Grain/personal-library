class AddForeignKeyToEvaluations < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :evaluations, :users, column: :user_id
    add_foreign_key :evaluations, :books, column: :book_id
  end
end
