class CreateBookUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :book_users do |t|
      t.references    :book,  foriegn_key: true
      t.references    :user,  foriegn_key: true
    end
  end
end
