# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Estate.destroy_all

users = []

User.create!(email: 'estate@yopmail.com', password: 'foobar')

puts 'estate@yopmail.com est créé'

10.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: 'foobar'
  )
  users << user
end

puts '10 users créés.'

40.times do
  Estate.create!(
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph_by_chars(number: 150, supplemental: false),
    price: rand(1..400_000),
    user: users.sample
  )
end

puts '40 Appartements en base.'
