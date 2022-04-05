FactoryBot.define do
  factory :inquiry do
    name { Faker::Name.name }
    name_kana { 'フリガナ' }
    email { Faker::Internet.unique.email }
    content { Faker::Lorem.paragraph }
    remote_ip { Faker::Number.number }
  end
end
