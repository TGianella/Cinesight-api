class WatchlistsController < ApplicationController
  before_action :get_watchlist
  before_action only: %i[include_movie remove_movie] do
    @movie = get_movie(params[:movie_id])
  end

  def show
    render json: @watchlist.movies
  end

  def include_movie
    if @watchlist.movies.include? movie
      head :conflict
    else
      @watchlist.movies << Movie.find(movie_id)
      head :ok
    end
  end

  def remove_movie
    if @watchlist.movies.include? movie
      @watchlist.movies.delete_if { |movie| movie.id == movie_id }
      head :ok
    else
      head :not_found
    end
  end

  private

  def get_watchlist
    @watchlist = current_user.watchlist
  end

  def get_movie(movie_id)
    @movie = Movie.find(movie_id)
  end
end
