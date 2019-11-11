class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string      :isbn
      t.string      :title
      t.string      :image
      t.text        :link_url
      t.references  :authoer,   foriegn_key: true
      t.references  :publisher, foriegn_key: true
    end
  end
end
