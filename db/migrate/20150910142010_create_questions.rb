class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.boolean :multiple, default: false

      t.timestamps null: false
    end
  end
end
