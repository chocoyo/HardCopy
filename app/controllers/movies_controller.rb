class MoviesController < ApplicationController
  def index
    @movies = Movie.all.page params[:page]
  end

  def show_movies_of_genre
    @genre = Genre.where(title: params[:title]).last
    @movies = Movie.where(genre: @genre).page params[:page]
  end
end
