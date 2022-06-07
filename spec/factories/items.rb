FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    genre { Faker::Lorem.word }
    image { Rails.root.join('spec/fixtures/test.jpg') }
    user
  end
end
