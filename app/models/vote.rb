class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll
  has_many :entities

  before_validation :clean_result

  validates :user_id, uniqueness: { scope: [:poll_id] }

  after_create :update_choices

  accepts_nested_attributes_for :entities

  private

  def clean_result
    choice_ids = Choice.joins(question: :poll).where(polls: { id: poll_id }).pluck(:id)

    self.result = result.select { |choice_id| choice_id.in? choice_ids }
  end

  def update_choices
    Choice.where(id: result).find_each do |choice|
      choice.submit(user_id)
    end
  end
end
