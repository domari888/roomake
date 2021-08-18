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

User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
  user.age = age
  user.address = address
  user.household = household
  puts 'ユーザーの初期データインポートに成功しました。'
end

# テスト投稿の初期データ
ActiveRecord::Base.connection.execute('TRUNCATE TABLE posts RESTART IDENTITY CASCADE')
post1 = Post.create!(content: 'テスト', user_id: 1)
post2 = Post.create!(content: 'テスト<br>テスト', user_id: 1)
post3 = Post.create!(content: '<h1>テスト</h1>', user_id: 1)
puts '投稿内容の初期データインポートに成功しました。'

ActiveRecord::Base.connection.execute('TRUNCATE TABLE photos RESTART IDENTITY CASCADE')
post1.photos.create!(image: image)
post2.photos.create!(image: image)
post3.photos.create!(image: image)
puts '投稿画像の初期データインポートに成功しました。'
