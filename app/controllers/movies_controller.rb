class MoviesController < ApplicationController
  require 'rest-client'

  def index
    url = 'https://api.themoviedb.org/3/movie/now_playing'
    response = queryExternalDB(url)

    render json: response
  end

  def search
    query = params[:query]
    url = "https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=fr-FR&page=1"
    response = queryExternalDB(url)

    render json: response
  end

  def show
    movie_id = params[:id]
    movie = Movies.find_by(id: movie_id)
    if movie.nil?
      url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US"
      response = queryExternalDB(url)

      movie = Movie.new(id: response.id,
                        title: response.title,
                        vote_average: response.vote_average,
                        poster_path: response.poster_path)

      movie.save!
    end

    render json: movie
  end

  private

  def queryExternalDB(url)
    RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
  end
end
