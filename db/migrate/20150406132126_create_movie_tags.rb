class CreateMovieTags < ActiveRecord::Migration
  def change
    create_table :movie_tags do |t|
      t.integer :user_id
      t.integer :movie_id
      t.string :tag
      t.datetime :timestamp
      t.timestamps null: false
    end
  end
end
