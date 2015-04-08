class CreateRating < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.decimal :rating
      t.datetime :timestamp
      t.timestamps null: false
    end
  end
end
