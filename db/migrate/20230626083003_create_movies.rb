class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies, id: false do |t|
      t.integer :id, options: :primary_key, null: false
      t.index :id, unique: true
      t.string :title, null: false
      t.float :vote_average
      t.integer :vote_count
      t.string :poster_path
      t.string :original_title
      t.text :overview
      t.string :release_date
      t.string :tagline

      t.timestamps
    end
  end
end
