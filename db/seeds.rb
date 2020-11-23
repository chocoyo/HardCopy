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

puts "Attempting To Pull From TMDB"

Tmdb::Api.key(ENV["API_KEY"])

Tmdb::Movie.find("spiderman").each do |movie|
  # Get Details Of Movie
  movie_details = Tmdb::Movie.detail(movie.id)

  # If the movie has no genres, skip it
  next if movie_details["genres"][0].nil?

  # Take the first genre (for now)
  genre = Genre.find_or_create_by(title: movie_details["genres"][0]["name"])

  # Create Movie
  Movie.create(title:       movie.title,
               director:    movie.original_title,
               description: movie.overview,
               genre:       genre)
end

puts "Added Data From IMDB"
