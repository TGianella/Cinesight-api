class WatchlistsController < ApplicationController
  def show
    @watchlist = current_user.watchlist

    render json: @watchlist.movies
  end

  def include_movie; end

  def remove_movie; end
end
