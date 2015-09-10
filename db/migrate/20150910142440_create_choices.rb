class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :title
      t.integer :limit, default: 0

      t.timestamps null: false
    end
  end
end
