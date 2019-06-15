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
  user = User.create(nickname: Faker::Name.name, contact_number: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, language: ['zh-cn', 'en-us'].sample)
  post = Post.create(description: Faker::Quote.famous_last_words, capacity: (2..20).to_a.sample, location: Faker::Address.full_address, contact_number: Faker::PhoneNumber.cell_phone, is_full: [true, false].sample, language: ['zh-cn', 'en-us'].sample, user: user)
  Comment.create(nickname: Faker::Name.name, comment: Faker::Quote.famous_last_words, language: ['zh-cn', 'en-us'].sample, post: post)
end
