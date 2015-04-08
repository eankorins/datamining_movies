class CreateMovie < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :director_id
      t.integer :length
      t.string :trailer_url
      t.string :mpaa_rating
      t.decimal :imdb_rating
      t.datetime :release_date
      t.integer :imdb_votes
      t.integer :release_year
      t.bool :adult
      t.string :backdrop_path
      t.integer :budget
      t.string :overview
      t.decimal :tmdb_popularity
      t.string :poster_path
      t.integer :revenue
      t.string :tagline
      t.decimal :tmdb_vote_average
      t.integer :tmdb_vote_count
      t.integer :imdb_id
      t.integer :tmdb_id
      t.timestamps null: false
    end
  end
end
