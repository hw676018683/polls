class AddUserIdsToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :user_ids, :integer, array: true, default: []
  end
end
