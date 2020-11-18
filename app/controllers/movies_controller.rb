class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show_movies_of_genre
    @genre = Genre.where(title: params[:title]).last
    @movies = Movie.where(genre: @genre)
  end
end
