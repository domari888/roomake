FactoryBot.define do
  factory :post_form do
    post { Post.new }
    content { Faker::Lorem.paragraph }
    image { [Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test.jpg'))] }
    tag_ids { [1, 2] }
    category_ids { [1, 2] }
  end
end
