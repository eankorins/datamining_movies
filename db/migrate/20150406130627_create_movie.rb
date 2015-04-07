class CreateMovie < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :imdb_id
      t.integer :tmdb_id
      t.timestamps null: false
    end
  end
end
