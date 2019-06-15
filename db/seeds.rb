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
  post = Post.create(description: Faker::Quote.famous_last_words, capacity: (2..20).to_a.sample, location: Faker::Address.full_address, contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: ['zh', 'en'].sample, user: user)
  Comment.create(nickname: Faker::Name.name, comment: Faker::Quote.famous_last_words, language: ['zh', 'en'].sample, post: post)
end

Post.create(description: "你好，你过来吧！", capacity: (2..20).to_a.sample, location: Faker::Address.full_address, contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'zh', user: User.first)
Post.create(description: "Shanghai", capacity: (2..20).to_a.sample, location: "Shanghai Pearl Tower", contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'en', user: User.first, lat: "31.240718842", long: "121.501045227")
Post.create(description: "Beijing", capacity: (2..20).to_a.sample, location: "Tian An Men", contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: 'en', user: User.first, lat: "39.907333374", long: "116.391082764")
