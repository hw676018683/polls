FactoryGirl.define do
  factory :choice do
    sequence(:title) { |n| "choice-#{n}" }
    limit 0
  end
end
