FactoryBot.define do
  factory :category do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "カテゴリ#{n}" }
  end
end
