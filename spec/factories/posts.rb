FactoryBot.define do
  factory :post do
    content { "MyText" }
    likes_count { 1 }
    marks_count { 1 }
    user { nil }
  end
end
