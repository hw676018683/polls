FactoryGirl.define do
  factory :user do
    uid { FFaker::Guid.guid }
    name { FFaker::NameCN.name }
    nickname { FFaker::Internet.user_name }
    phone { FFaker::PhoneNumber.phone_number }
    headimgurl { FFaker::Avatar.image }
  end
end
