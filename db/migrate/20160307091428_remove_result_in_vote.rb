class RemoveResultInVote < ActiveRecord::Migration
  def change
    remove_column :votes, :result, :integer, default: [], array: true
  end
end
