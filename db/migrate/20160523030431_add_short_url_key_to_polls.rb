class AddShortUrlKeyToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :short_url_key, :string
  end
end
