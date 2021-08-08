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

User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
  user.age = age
  user.address = address
  user.household = household
  puts 'ユーザーの初期データインポートに成功しました。'
end
