FactoryBot.define do
  factory :know_how do
    genre { rand(1..7) }
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end
