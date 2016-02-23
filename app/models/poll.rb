class Poll < ActiveRecord::Base
  @@redis = Redis.new(:host => "127.0.0.1", :port => "6379", :db => 15)

  validates :title, presence: {message: '请填写表单标题'}

  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user

  accepts_nested_attributes_for :questions, allow_destroy: true

  after_create :cache_limit

  def user_submitted?(user)
    result = false

    questions.each do |question|
      result = true if question.choices.any? { |choice| choice.user_ids.include?(user.id) }
    end

    result
  end

  def check_if_beyong_limit choice_ids = []
    choice_ids = choice_ids - (choice_ids - Choice.joins(question: :poll).where(polls: { id: id }).where.not(limit: nil).pluck(:id))
    pop_choice_ids = []

    choice_id = choice_ids.find do |choice_id|
      if @@redis.rpop "choice_#{choice_id}_limit"
        pop_choice_ids << choice_id
        false
      else
        true
      end
    end

    if choice_id
      pop_choice_ids.each do |choice_id|
        @@redis.lpush "choice_#{choice_id}_limit", 1
      end
      true
    else
      false
    end
  end

  def submitted? user
    voter_ids = @@redis.lrange "poll_#{id}_voters", 0, -1
    voter_ids.include?(user.id)
  end

  def cache_voter user
    @@redis.lpush "poll_#{id}_voters", user.id
  end

  private

  def cache_limit
    choices = Choice.joins(question: :poll).where(polls: { id: id }).where.not(limit: nil)
    choices.each do |choice|
      @@redis.rpush "choice_#{choice.id}_limit", [1]*chocie.limit
    end
  end
end
