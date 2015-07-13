class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :question_id
      t.string :query

      t.timestamps null: false
    end
  end
end
