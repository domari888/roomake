FactoryBot.define do
  factory :tag do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "タグ#{n}" }
  end
end
