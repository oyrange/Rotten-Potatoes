class Movie < ActiveRecord::Base
  # attr_accessor :possible_ratings
  POSSIBLE_RATINGS = (%w[G PG PG-13 R])
  # def new
  #   @@possible_ratings = (%w[G PG PG-13 R])
  # end

  def self.possible_ratings arg=nil
    #raise TypeError 'Rating must be a string' unless arg.is_a? String
    unless arg
      return POSSIBLE_RATINGS
    end
    POSSIBLE_RATINGS << arg
  end

  def self.get_movies_rated(ratings)
    ratings = [ratings] unless ratings.is_a?(Array)
    where(rating: ratings)
  end
end
