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

Tmdb::Movie.find("harry potter").each do |movie|
  # Get Details Of Movie
  movie_details = Tmdb::Movie.detail(movie.id)

  # If the movie has no genres, skip it
  next if movie_details["genres"][0].nil?

  # Take the first genre (for now)
  genre = Genre.find_or_create_by(title: movie_details["genres"][0]["name"])

  # Get name of image on server
  imageName = Tmdb::Movie.images(movie.id)["posters"][0]["file_path"]

  # Download Image
  tempImage = Down.download("http://image.tmdb.org/t/p/w500/" + imageName)

  # Create Movie
  newMovie = Movie.create(title:       movie.title,
                          director:    movie.original_title,
                          description: movie.overview,
                          price:       rand(1..20),
                          genre:       genre)

  # Attach images to the new movie
  newMovie.image.attach(io: File.open(tempImage), filename: imageName, content_type: "image/jpg")

rescue StandardError => e
  puts "Movie " + movie.title + " has missing data... skipping"
end

puts "Added Data From IMDB"
