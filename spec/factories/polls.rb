FactoryGirl.define do
  factory :poll do
    title { FFaker::LoremCN.word }
    description { FFaker::LoremCN.paragraphs }
  end
end
