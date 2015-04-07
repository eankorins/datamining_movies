class User < ActiveRecord::Base
	has_many :tags
	has_many :ratings
	has_many :movies, through: :ratings
end
