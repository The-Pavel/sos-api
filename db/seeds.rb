# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Comment.destroy_all
Post.destroy_all
User.destroy_all
puts "cleared"

3.times do
  puts 'creating user - post - comment pair'
  user = User.create(nickname: Faker::Name.name, contact_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, language: ['zh', 'en'].sample)
  # post = Post.create(description: Faker::Quote.famous_last_words, capacity: (2..20).to_a.sample, location: Faker::Address.full_address, contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: ['zh', 'en'].sample, user: user)
  # Comment.create(nickname: Faker::Name.name, comment: Faker::Quote.famous_last_words, language: ['zh', 'en'].sample, post: post)
end

Post.create(description: "我这里是一家药房", capacity: (2..20).to_a.sample, location: "华民大药房", contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'zh', user: User.first, lat: "31.11444", long: "121.37962")

post1 = Post.create(description: "My office can house a few people. All are welcome.", capacity: (2..20).to_a.sample, location: "Yinghua International Plaza", contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'en', user: User.first, lat: "31.11325", long: "121.38206")

post2 = Post.create(description: "This is KFC, you can sleep in the restaurant and use the kitchen to cook.", capacity: (2..20).to_a.sample, location: "KFC Minghang 1", contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'en', user: User.first, lat: "31.11258", long: "121.38474")

Comment.create(nickname: Faker::Name.name, comment: Faker::Quote.famous_last_words, language: ['en'].sample, post: post1)
Comment.create(nickname: Faker::Name.name, comment: Faker::Quote.famous_last_words, language: ['en'].sample, post: post2)
