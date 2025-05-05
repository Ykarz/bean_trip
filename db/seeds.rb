# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# 各テーブルの初期化
User.destroy_all
Store.destroy_all
Country.destroy_all
Bean.destroy_all

# usersテーブルのレコードを5つ作成
5.times do
  User.create!(
    name: Faker::Name.unique.first_name[0..19].ljust(4, 'a'),
    email: Faker::Internet.unique.email,
    password: "password"
  )
end

# usersテーブルの全てのレコードの主キーを配列に格納
user_ids = User.ids

# countriesテーブルのレコードを5つ作成
country_names = ["エチオピア", "コロンビア", "グアテマラ", "ジャマイカ", "インドネシア"]
country_names.map do |name|
  Country.create!(name: name)
end

country_ids = Country.ids

# storesテーブルのレコードを作成
Store.create!(
  place_id: "ChIJk9cPpmnI9F8Runegy0UNh2k",
  name: "自家焙煎珈琲屋 豆煎坊",
  post_code: "950-2004",
  address: "新潟県新潟市西区平島１丁目４−５",
  latitude: 37.8926076,
  longitude: 139.0049152
)

Store.create!(
  place_id: "ChIJG77BNdI4i18RBvk3P2edFaE",
  name: "珈琲舎ぐれ",
  post_code: "959-2646",
  address: "新潟県胎内市西栄町２−３５",
  latitude: 38.0532879,
  longitude: 139.4005729
  )

store_ids = Store.ids

# beansテーブルのレコードを20件作成
20.times do
  Bean.create!(
    name: Faker::Coffee.blend_name,
    area: Faker::Address.city,
    farm: "#{Faker::Name.last_name}農園",
    roast_level: rand(1..3),
    blended: [true, false].sample,
    bitterness: rand(1..5),
    sweetness: rand(1..5),
    acidity: rand(1..5),
    body: rand(1..5),
    aroma: rand(1..5),
    comment: Faker::Coffee.notes,
    country_id: country_ids.sample,
    store_id: store_ids.sample,
    user_id: user_ids.sample
  )
end