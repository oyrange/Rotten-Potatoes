class Movie < ActiveRecord::Base
  attr_accessor :possible_ratings
  def new
    @possible_ratings = (%w[G PG PG-13 R])
  end

  def self.get_movies_rated(ratings)
    ratings = [ratings] unless ratings.is_a?(Array)
    where(rating: ratings)
  end
end
