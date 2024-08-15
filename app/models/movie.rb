class Movie < ActiveRecord::Base
  POSSIBLE_RATINGS = (%w[G PG PG-13 R])

  def self.possible_ratings arg=nil
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
