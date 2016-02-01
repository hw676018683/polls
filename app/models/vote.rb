class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  before_validation :clean_result

  private

  def clean_result
    choice_ids = Choice.joins(question: :poll).where(polls: { id: poll_id }).pluck(:id)

    self.result = result.select { |choice_id| choice_id.in? choice_ids }
  end
end
