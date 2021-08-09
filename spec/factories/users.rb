FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    age { rand(1..7) }
    address { rand(1..47) }
    household { rand(1..6) }
    profile { Faker::Lorem.sentence }
    avater { Rack::Test::UploadedFile.new(Rails.root.join('images/fallback/default.png')) }
  end
end
