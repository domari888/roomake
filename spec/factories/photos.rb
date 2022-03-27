FactoryBot.define do
  factory :photo do
    sequence(:id) { |n| n }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
    post
  end
end
