class Poll < ActiveRecord::Base
  @@redis = Redis.new(:host => "127.0.0.1", :port => "6379", :db => 15)

  validates :title, presence: {message: '请填写表单标题'}

  has_many :questions, dependent: :destroy
  has_many :votes, dependent: :destroy

  belongs_to :user

  accepts_nested_attributes_for :questions, allow_destroy: true

  after_create :cache_limit

  def check_if_beyong_limit choice_ids = []
    choice_ids &= Choice.joins(question: :poll).where(polls: { id: id }).where.not(limit: nil).pluck(:id)
    pop_choice_ids = []

    choice_id = choice_ids.find do |choice_id|
      if @@redis.rpop Choice.limit_key(choice_id)
        pop_choice_ids << choice_id
        false
      else
        true
      end
    end

    if choice_id
      pop_choice_ids.each do |choice_id|
        @@redis.lpush Choice.limit_key(choice_id), 1
      end
      true
    else
      false
    end
  end

  def submitted? user
    voter_ids = @@redis.lrange Poll.voters_key(id), 0, -1
    voter_ids.include?(user.id.to_s)
  end

  def cache_voter user
    @@redis.lpush Poll.voters_key(id), user.id
  end

  def writable?
    started? && !ended?
  end

  def started?
    !(started_at && Time.now < started_at)
  end

  def ended?
    ended_at && Time.now > ended_at
  end

  def time_description
    description = []
    description << (started_at ? "开始时间：#{started_at.strftime "%F %R"}" : nil)
    description << (ended_at ? "结束时间：#{ended_at.strftime "%F %R"}" : nil)
    description.compact.join('，')
  end

  def self.voters_key id
    "#{Rails.env}_poll_#{id}_voters"
  end

  def self.redis
    @@redis
  end

  private

  def cache_limit
    choices = Choice.joins(question: :poll).where(polls: { id: id }).where('choices.limit>0')
    choices.each do |choice|
      @@redis.rpush Choice.limit_key(choice.id), [1]*choice.limit
    end
  end
end
