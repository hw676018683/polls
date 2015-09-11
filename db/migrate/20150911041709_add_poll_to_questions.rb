class AddPollToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :poll, index: true, foreign_key: true
  end
end
