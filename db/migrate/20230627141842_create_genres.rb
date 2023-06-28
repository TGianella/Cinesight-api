class CreateGenres < ActiveRecord::Migration[7.0]
  def change
    create_table :genres, id: false do |t|
      t.integer :id, options: :primary_key, null: false
      t.index :id, unique: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
