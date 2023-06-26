class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies, id: false do |t|
      t.integer :id, options: :primary_key, null: false
      t.index :id, unique: true
      t.string :title
      t.float :vote_average
      t.string :poster_path

      t.timestamps
    end
  end
end
