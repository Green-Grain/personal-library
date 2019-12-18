class CreateApiHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :api_histories do |t|
      t.integer :call_count
      t.timestamps
    end
  end
end
