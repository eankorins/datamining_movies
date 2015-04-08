require 'csv'
require 'date'
namespace :movielens do
  desc "Lods All Data"
  task load_data: :environment do
    #add_movies
    #add_ratings
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
        puts "Inserted #{slice.count} Movies"
      end
    end
    puts ""
  end

  desc "Loads Ratings and adds new Users"
  def add_ratings
    counter = 0
    users = []
    ratings = []
    CSV.foreach('ratings.csv') do |r|
      user_id, movie_id, rating, timestamp = r
      users << user_id
      ratings << Rating.new(:user_id => user_id, :movie_id => movie_id, :rating => rating, :timestamp => DateTime.strptime(timestamp,'%s'))
      print "Ratings Counter: #{counter} \r" 
      counter += 1
    end
    ActiveRecord::Base.transaction do
      users.uniq.each do |user|
          User.create(:id => user)
      end
    end
    ratings.each_slice(1000) do |slice|
      ActiveRecord::Base.transaction do
        
          slice.each { |r| r.save! }
      end
    end
    puts ""
  end

  desc "Loads Tags and adds new Users"
  def add_tags
    counter = 0
    users = []
    ratings = []
    CSV.foreach('tags.csv') do |r|
      user_id, movie_id, tag, timestamp = r
      users << user_id
      ratings << Tag.new(:user_id => user_id, :movie_id => movie_id, :tag => tag, :timestamp => DateTime.strptime(timestamp,'%s'))
      print "Tag Counter: #{counter} \r" 
      counter += 1
    end
    ActiveRecord::Base.transaction do
      ratings.each { |r| r.save! }
    end
    puts ""
  end

  desc "Loads Links (Movie IDs for API)"
  def add_links
    counter = 0 
    movies = []
    CSV.foreach('links.csv') do |r|
      movie_id, imdb, tmdp = r
      movie = Movie.find_by_id(movie_id)
      movie.imdb_id = imdb
      movie.tmdb_id = tmdp
      movies << movie
      print "Links Counter: #{counter} \r" 
      counter += 1
    end
    ActiveRecord::Base.transaction do
      movies.each{ |m| m.save! }
    end

    puts ""
  end

end
