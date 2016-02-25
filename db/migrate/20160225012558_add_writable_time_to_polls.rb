class AddWritableTimeToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :writable_time, :datetime
  end
end
