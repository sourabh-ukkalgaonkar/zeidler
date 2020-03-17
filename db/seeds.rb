# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

(0..5).each do |i|
  Category.create(name: Faker::Game.title)
end

User.create(name: 'tester@yopmail.com', password: '123456', name: 'tester')

users = (0..5).map do |i|
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123456'
  )
end

(0..5).each do |i|
  article = users[0].articles.create(title: Faker::Name.name, text: Faker::Address::full_address, status: Article::statuses['published'])
  article.categories << Category.first(rand(1..5))
end