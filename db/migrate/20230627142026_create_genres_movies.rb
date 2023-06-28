class CreateGenresMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :genres_movies, id: false do |t|
      t.references :genre, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.index %i[movie_id genre_id], unique: true
    end
  end
end
