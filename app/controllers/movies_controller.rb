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
      url = "https://api.themoviedb.org/3/movie/#{movie_id}?language=fr-FR"
      response = queryExternalDB(url)
      body = JSON.parse(response.body, { symbolize_names: true })

      movie = Movie.new(id: body[:id],
                        title: body[:title],
                        vote_average: body[:vote_average],
                        vote_count: body[:vote_count],
                        poster_path: body[:poster_path],
                        original_title: body[:original_title],
                        overview: body[:overview],
                        release_date: body[:release_date],
                        tagline: body[:tagline])

      movie.save!
    end

    render json: movie
  end

  private

  def queryExternalDB(url)
    RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
  end
end
