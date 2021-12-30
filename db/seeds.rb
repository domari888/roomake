# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# テストユーザーの初期データ
email = 'test@example.com'
password = 'password'
name = 'テストユーザー'
age = 'twenties'
address = 'kanagawa'
household = 'two_person_household'
image = File.open(Rails.root.join('public/images/fallback/test.png'))
content = 'コメント内容を表示します'
tags = ['キッチン', 'リビング', 'バス', 'トイレ', 'バルコニー', '洗面台', '寝室', '洋室', '和室', '子供部屋', '玄関', 'その他']
categories = ['成功', '失敗', 'おすすめ', 'DIY', '紹介', 'その他']

%w[users posts photos tags categories post_tags post_categories likes marks].each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name} RESTART IDENTITY CASCADE")
end

tags.each { |tag| Tag.create!(name: tag) }
puts 'タグの初期データインポートに成功しました。'

categories.each { |category| Category.create!(name: category) }
puts 'カテゴリーの初期データインポートに成功しました。'

User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
  user.age = age
  user.address = address
  user.household = household
  puts 'テストユーザーの初期データインポートに成功しました。'
end

1000.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    age: age,
    address: address,
    household: household
  )
end
puts 'ユーザーの初期データ 1000 件のインポートに成功しました。'

1000.times do
  post = Post.create!(
    content: Faker::Lorem.paragraph(sentence_count: 100),
    user_id: rand(1..100)
  )
  post.photos.create!(image: image)
  post.post_tags.create!(tag_id: rand(1..12))
  post.post_categories.create!(category_id: rand(1..6))
  post.comments.create!(content: content, user_id: rand(1..100))
  post.likes.create!(user_id: rand(1..100))
  post.marks.create!(user_id: rand(1..100))
end
puts '投稿の初期データ 1000 件のインポートに成功しました。'
