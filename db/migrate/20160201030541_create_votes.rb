class CreateVotes < ActiveRecord::Migration
  def up
    create_table :votes do |t|
      t.integer :user_id, index: true
      t.integer :poll_id, index: true
      t.integer :result, array: true, default: []

      t.timestamps null: false
    end
  end

  def down
    drop_table :votes do |t|
    end
  end
end
