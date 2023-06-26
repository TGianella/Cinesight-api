class MoviesController < ApplicationController
  require 'rest-client'

  def index
    url = 'https://api.themoviedb.org/3/movie/now_playing'
    response = query_external_db(url)

    render json: response
  end

  def search
    query = params[:query]
    url = "https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=fr-FR&page=1"
    response = query_external_db(url)

    render json: response
  end

  def show
    movie_id = params[:id]
    movie = Movie.find_by(id: movie_id)
    if movie
      render json: movie
      return
    end

    detailsUrl = "https://api.themoviedb.org/3/movie/#{movie_id}?language=fr-FR"
    response = query_external_db(detailsUrl)

    if response.present?
      movie = parse_response(response)

      creditsUrl = "https://api.themoviedb.org/3/movie/#{movie_id}/credits?language=fr-FR"
      response = query_external_db(creditsUrl)
      body = JSON.parse(response.body, { symbolize_names: true })
      director = body[:crew].select { |crew_member| crew_member[:job] == 'Director' }.first

      movie.update!(director: director[:name])

      render json: movie
    else
      render json: { error: 'not-found' }, status: :not_found
    end
  end

  private

  def query_external_db(url)
    RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })
  rescue RestClient::NotFound
    nil
  end

  def parse_response(response)
    body = JSON.parse(response.body, { symbolize_names: true })
    register_movie(body)
  end

  def register_movie(body)
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
    movie
  end
end
