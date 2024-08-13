class Movie < ActiveRecord::Base
  attr_accessor :possible_ratings
  def new
    @possible_ratings = (%w[G PG PG-13 R])
  end
end
