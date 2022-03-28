FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    likes_count { nil }
    marks_count { 0 }
    user
    after(:create) do |post|
      create(:photo, post: post)
      create(:post_tag, post: post)
      create(:post_category, post: post)
    end
  end
end
