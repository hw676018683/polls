class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.integer :question_id, index: true
      t.integer :vote_id, index: true
      t.integer :choice_id, index: true
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
