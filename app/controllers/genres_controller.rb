class GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:genre_id])

    render json: @genre
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: 404,
      message: "Couldn't find genre in local db"
    }, status: :not_found
  end
end
