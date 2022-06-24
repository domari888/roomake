FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    genre { Faker::Lorem.word }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
    remote_image_url { Faker::Avatar.image }
    user
  end
end
