require 'csv'
require 'date'
namespace :movielens do
  desc "Lods All Data"
  task load_data: :environment do
    add_movies
    add_ratings
    add_tags
    add_links
  end
  desc "Loads Movie and Genre Data"
  def add_movies
    movies = []
    counter = 0;
    CSV.foreach('movies.csv') do |m|
      id, title, genres = m
      genres = genres.split('|')

      m = Movie.new(:id => id, :title => title)
      genres.each { |g| m.genres.build(:name => g)}
      print "Movie Counter: #{counter} \r" 
      counter += 1
      movies << m
    end

    counter = 0
    movies.each_slice(1000) do |slice|
      ActiveRecord::Base.transaction do
        slice.each { |m| m.save! }
        puts "Inserted #{(counter + 1) * 1000} Movies"
      end
    end
    puts ""
  end

  desc "Loads Ratings and adds new Users"
  def add_ratings
    counter = 0
    CSV.foreach('ratings.csv') do |r|
      user_id, movie_id, rating, timestamp = r
      user = User.find_by_id(user_id) || User.create(:id => user_id)
      movie = Movie.find_by_id(movie_id)
      movie.ratings.create(:user_id => user.id, :rating => rating, :timestamp => DateTime.strptime(timestamp,'%s'))

      print "Ratings Counter: #{counter} \r" 
      counter += 1
    end
    puts ""
  end

  desc "Loads Tags and adds new Users"
  def add_tags
    counter = 0
    CSV.foreach('tags.csv') do |r|
      user_id, movie_id, rating, timestamp = r
      user = User.find_by_id(user_id) || User.create(:id => user_id)
      movie = Movie.find_by_id(movie_id)
      movie.tags.create(:user_id => user.id, :rating => rating, :timestamp => DateTime.strptime(timestamp,'%s'))

      print "Tags Counter: #{counter} \r" 
      counter += 1
    end
    puts ""
  end

  desc "Loads Links (Movie IDs for API)"
  def add_links
    CSV.foreach('links.csv') do |r|
      movie_id, imdb, tmdb = r
      movie = Movie.find_by_id(movie_id)
      movie.imdb_id = imdb
      movie.tmdb_id = tmdp
      movie.save!
      print "Links Counter: #{counter} \r" 
      counter += 1
    end
    puts ""
  end

end
