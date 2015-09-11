class Choice < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :question
end
