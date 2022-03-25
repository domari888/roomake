FactoryBot.define do
  factory :photo do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg')) }
    post
  end
end
