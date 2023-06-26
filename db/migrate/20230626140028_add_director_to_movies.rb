class AddDirectorToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :director, :string
  end
end
