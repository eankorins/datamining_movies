class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :movie_id
      t.integer :user_id

      t.string :tag
    end
  end
end
