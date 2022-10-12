FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    age { rand(1..7) }
    address { rand(1..47) }
    household { rand(1..6) }
    favorite_items { Faker::Lorem.word }
    profile { Faker::Lorem.sentence }
    avatar { Rack::Test::UploadedFile.new(Rails.public_path.join('images/fallback/default.png')) }
  end

  factory :guest_user, class: 'User' do
    name { 'ゲストユーザー' }
    email { 'guest@example.com' }
    password { Faker::Internet.password(min_length: 8) }
    age { 2 }
    address { 13 }
    household { 2 }
  end
end
