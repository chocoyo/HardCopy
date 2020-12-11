logger = Rails.logger

logger.info "Setting up active admin"
AdminUser.destroy_all

if Rails.env.development?
  AdminUser.create!(email: "admin@example.com",
    password: "password", password_confirmation: "password")
end

logger.info "Deleting data"
Movie.destroy_all
Genre.destroy_all
User.destroy_all
OrderedProduct.destroy_all
Order.destroy_all
OrdersStatus.destroy_all
Province.destroy_all

logger.info "Adding Provinces"
path = File.join(File.dirname(__FILE__), "provinces.json")
records = JSON.parse(File.read(path))
records.each do |record|
  Province.create(
    name: record["name"],
    PST:  record["pst"].to_i,
    HST:  record["hst"].to_i
  )
end

logger.info "Adding Order Statuses"
OrdersStatus.create(name: "New")
OrdersStatus.create(name: "Paid")
OrdersStatus.create(name: "Shipped")

logger.info "Attempting To Pull From TMDB"
Tmdb::Api.key(ENV["API_KEY"])

Tmdb::Movie.find("harry potter").each do |movie|
  # Get Details Of Movie
  movie_details = Tmdb::Movie.detail(movie.id)

  # If the movie has no genres, skip it
  next if movie_details["genres"][0].nil?

  # Take the first genre (for now)
  genre = Genre.find_or_create_by(title: movie_details["genres"][0]["name"])

  # Get name of image on server
  image_name = Tmdb::Movie.images(movie.id)["posters"][0]["file_path"]

  # Download Image
  temp_image = Down.download("http://image.tmdb.org/t/p/w500/#{image_name}")

  # Create Movie
  new_movie = Movie.create(title:       movie.title,
                           director:    movie.original_title,
                           description: movie.overview,
                           price:       rand(100..2000),
                           genre:       genre)

  # Attach images to the new movie
  new_movie.image.attach(io: File.open(temp_image), filename: image_name, content_type: "image/jpg")

rescue StandardError
  logger.info "Movie #{movie.title} has missing data... skipping"
end

logger.info "Added Data From IMDB"
