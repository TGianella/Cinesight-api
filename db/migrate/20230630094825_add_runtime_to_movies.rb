class AddRuntimeToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :runtime, :integer
  end
end
