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

User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
  user.age = age
  user.address = address
  user.household = household
  puts 'ユーザーの初期データインポートに成功しました。'
end

ActiveRecord::Base.connection.execute('TRUNCATE TABLE tags RESTART IDENTITY CASCADE')
tags.each do |tag|
  Tag.create!(name: tag)
end
puts 'タグの初期データインポートに成功しました。'

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

ActiveRecord::Base.connection.execute('TRUNCATE TABLE comments RESTART IDENTITY CASCADE')
post1.comments.create!(content: content, user_id: 1)
post2.comments.create!(content: content, user_id: 1)
post3.comments.create!(content: content, user_id: 1)
puts 'コメントの初期データインポートに成功しました。'

ActiveRecord::Base.connection.execute('TRUNCATE TABLE post_tags RESTART IDENTITY CASCADE')
post1.post_tags.create!(tag_id: 1)
post2.post_tags.create!(tag_id: 2)
post3.post_tags.create!(tag_id: 3)
puts '投稿タグの初期データインポートに成功しました。'
