# frozen_string_literal: true

require 'rails_helper'

describe Movie do
  it 'should understand possible ratings' do
    expect(Movie.possible_ratings).to eq(%w[G PG PG-13 R])
  end

  it 'should be able to get movies with specified ratings' do
    r_movie_search = Movie.get_movies_rated('R')
    expect(r_movie_search.rating.uniq.count).to eq(1)
    expect(r_movie_search.first.rating).to eq('R')
  end
end
