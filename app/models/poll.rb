class Poll < ActiveRecord::Base
  validates :title, presence: {message: '请填写表单标题'}

  has_many :questions, dependent: :destroy
  belongs_to :user

  accepts_nested_attributes_for :questions, allow_destroy: true

  def user_submitted?(user)
    result = false

    questions.each do |question|
      result = true if question.choices.any? { |choice| choice.user_ids.include?(user.id) }
    end

    result
  end
end
