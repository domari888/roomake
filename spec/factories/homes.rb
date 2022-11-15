FactoryBot.define do
  factory :home do
    title { Faker::Lorem.word }
    subtitle { Faker::Lorem.word }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
    content { Faker::Lorem.sentences }
  end
end
