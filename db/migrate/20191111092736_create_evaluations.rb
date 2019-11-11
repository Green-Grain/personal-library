class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.text        :comment,   null: false
      t.boolean     :positive,  default: true
      t.references  :book,      foriegn_key: true
      t.references  :user,      foriegn_key: true
      t.timestamps
    end
  end
end
