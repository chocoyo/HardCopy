# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Setting up active admin"
AdminUser.destroy_all

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com", password: "password", password_confirmation: "password")
end

puts "Deleting data"
Movie.destroy_all
Genre.destroy_all

puts "Adding basic data"
action = Genre.create(title: "Action")
horror = Genre.create(title: "Horror")
family = Genre.create(title: "Family")

Movie.create(title: "Mission Impossible", director: "Not Me", description: "Crazy Movie", genre: action)
Movie.create(title: "Very Scary Movie", director: "Also Not Me", description: "Crazy Movie", genre: horror)
Movie.create(title: "Cars", director: "Lighting McQueen", description: "Crazy Movie", genre: family)

puts "Added Data"
