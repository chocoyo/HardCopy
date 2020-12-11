class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show_movies_of_genre
    @genre = Genre.where(title: params[:title]).last
    @movies = Movie.where(genre: @genre)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def search
    if params[:search].blank? || params[:category].blank?
      # Nothing!
    elsif params[:category] == "genre" # Search by genre
      @genre = Genre.where("lower(title) LIKE :search", search: "%#{params[:search].downcase}%")
      @movies = Movie.where(genre: @genre)
    elsif params[:category] == "title" # Search by movie title
      @movies = Movie.where("lower(title) LIKE :search", search: "%#{params[:search].downcase}%")
    end
  end

end
