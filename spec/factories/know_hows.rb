FactoryBot.define do
  factory :know_how do
    sequence(:genre) { |n| n }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
