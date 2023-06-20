class MoviesController < ApplicationController
  require 'rest-client'

  def index
    url = 'https://api.themoviedb.org/3/movie/now_playing'
    response = RestClient.get(url, { Authorization: "Bearer #{ENV.fetch('API_KEY')}" })

    render json: response
  end
end
