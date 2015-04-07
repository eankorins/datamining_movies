class Movie < ActiveRecord::Base
	has_many :ratings
	has_many :users, through: :ratings
	has_many :tags
	has_many :genres
end
