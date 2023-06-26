class WatchlistsController < ApplicationController
  before_action :get_watchlist

  def show
    render json: @watchlist.movies
  end

  def include_movie
    movie_id = params[:movie_id]

    @watchlist.movies << Movie.find(movie_id)  
  end

  def remove_movie
    movie_id = params[:movie_id]

    @watchlist.movies.delete_if { |movie| movie.id == movie_id }
  end

  private

  def get_watchlist
    @watchlist = current_user.watchlist
  end
end
