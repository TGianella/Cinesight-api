class MoviesController < ApplicationController
  include ImportMovie

  def now_playing
    url = 'https://api.themoviedb.org/3/movie/now_playing'
    response = query_external_db(url)

    render json: response
  end

  def popular
    url = 'https://api.themoviedb.org/3/movie/popular'
    response = query_external_db(url)

    render json: response
  end

  def top_rated
    url = 'https://api.themoviedb.org/3/movie/top_rated'
    response = query_external_db(url)

    render json: response
  end

  def upcoming
    url = 'https://api.themoviedb.org/3/movie/upcoming'
    response = query_external_db(url)

    render json: response
  end

  def similar
    movie_id = params[:id]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}/similar"
    response = query_external_db(url)

    render json: response
  end

  def search
    query = params[:query]
    url = "https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=fr-FR&page=1"
    response = query_external_db(url)

    render json: response
  end

  def discover
    genre_id = params[:genre_id]
    url = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=fr-FR&page=1&sort_by=popularity.desc&with_genres=#{genre_id}"
    response = query_external_db(url)

    render json: response
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      movie = update_director(movie_id) if movie.director.blank?
      render json: movie, include: { genres: { only: %i[id name] } }
      return
    end

    movie = import_movie_from_tmdb(movie_id)

    if movie
      render json: movie, include: { genres: { only: %i[id name] } }
    else
      render json: { error: 'not-found' }, status: :not_found
    end
  end
end
