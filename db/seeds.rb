# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# テストユーザーの初期データ
email = 'test@example.com'
password = 'password'
name = 'テストユーザー'
age = 'twenties'
address = 'kanagawa'
household = 'two_person_household'

# 投稿の初期データ
image = File.open(Rails.root.join('app/assets/images/test.jpg'))
content = 'コメント内容を表示します'

# タグの初期データ
tags = ['整理', '収納', '間取り', 'レイアウト', '設備', 'DIY', '一戸建て', '賃貸', 'マイホーム', '注文住宅', '平屋', '一人暮らし', '新築', 'リノベーション', 'インテリア', '家具・家電', '紹介', 'その他']

# カテゴリの初期データ
categories = ['キッチン', 'リビング', 'ダイニング', 'バス', 'トイレ', 'バルコニー', '洗面台', '寝室', '洋室', '和室', '子供部屋', '玄関', '書斎', '庭', 'ガレージ', 'クローゼット', '階段', 'その他']

# テストユーザーアイテムの初期データ
items = RakutenWebService::Ichiba::Product.search(keyword: 'ダイソン', hits: 30)

# 管理者ユーザー用メールアドレス
admin_email = 'admin@example.com'

%w[users posts photos tags categories post_tags post_categories likes marks admin_users know_hows items].each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name} RESTART IDENTITY CASCADE")
end

tags.each { |tag| Tag.create!(name: tag) }
puts 'タグの初期データインポートに成功しました。'

categories.each { |category| Category.create!(name: category) }
puts 'カテゴリーの初期データインポートに成功しました。'

test_user = User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
  user.age = age
  user.address = address
  user.household = household
  puts 'テストユーザーの初期データインポートに成功しました。'
end

items.each do |item|
  Item.create!(
    name: item['productName'],
    genre: item['genreName'],
    remote_image_url: item['mediumImageUrl'],
    user_id: test_user.id
  )
end
puts 'テストユーザーアイテムの初期データ 30 件のインポートに成功しました。'

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
    user_id: rand(1..1000)
  )
  post.photos.create!(image: image)
  post.post_tags.create!(tag_id: rand(1..12))
  post.post_categories.create!(category_id: rand(1..6))
  post.comments.create!(content: content, user_id: rand(1..1000))
  post.likes.create!(user_id: rand(1..1000))
  post.marks.create!(user_id: rand(1..1000))
end
puts '投稿の初期データ 1000 件のインポートに成功しました。'

AdminUser.find_or_create_by!(email: admin_email) do |admin_user|
  admin_user.password = password
  puts '管理者の初期データインポートに成功しました。'
end

CSV.foreach('db/csv_data/know_how_data.csv', headers: true) do |row|
  KnowHow.create(
    genre: row['genre'],
    title: row['title'],
    content: row['content']
  )
end
puts 'ノウハウの初期データインポートに成功しました。'
