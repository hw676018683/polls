FactoryGirl.define do
  factory :question do
    title { FFaker::LoremCN.word }
    multiple false
  end
end
