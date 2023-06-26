class CreateMoviesWatchlists < ActiveRecord::Migration[7.0]
  def change
    create_table :movies_watchlists do |t|
      t.references :watchlist, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
