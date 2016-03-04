class AddEndedAtToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :ended_at, :datetime
    rename_column :polls, :writable_time, :started_at
  end
end
