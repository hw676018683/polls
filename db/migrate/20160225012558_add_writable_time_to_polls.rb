class AddWritableTimeToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :started_at, :datetime
  end
end
