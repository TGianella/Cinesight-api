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
    movie = Movie.find_by(id: movie_id)
    if movie.nil?
      puts 'JE QUERY TMDB'
      puts '$' * 60
      url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=en-US"
      response = queryExternalDB(url)
      body = JSON.parse(response.body, { symbolize_names: true })

      movie = Movie.new(id: body[:id],
                        title: body[:title],
                        vote_average: body[:vote_average],
                        poster_path: body[:poster_path])

      movie.save!
    end

    render json: movie
  end

  private

  def queryExternalDB(url)
    RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
  end
end
