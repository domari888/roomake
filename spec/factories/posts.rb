FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    likes_count { rand(0..100) }
    marks_count { rand(0..100) }
    user
  end
end
