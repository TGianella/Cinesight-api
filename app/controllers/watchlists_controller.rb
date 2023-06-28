class WatchlistsController < ApplicationController
  include ImportMovie
  before_action :authenticate_user!
  before_action :find_watchlist
  before_action only: %i[include_movie remove_movie] do
    @movie = find_movie(params[:movie_id])
  end

  def show
    render json: @watchlist.movies
  end

  def include_movie
    if @watchlist.movies.include? @movie
      head :conflict
    else
      @watchlist.movies << @movie
      head :ok
    end
  end

  def remove_movie
    if @watchlist.movies.include? @movie
      @watchlist.movies.delete(@movie)
      head :ok
    else
      head :not_found
    end
  end

  private

  def find_watchlist
    @watchlist = current_user.watchlist || Watchlist.create(user: current_user)
  end

  def find_movie(movie_id)
    @movie = Movie.find(movie_id)
  rescue ActiveRecord::RecordNotFound
    @movie = import_movie_from_tmdb(movie_id)
  end
end
