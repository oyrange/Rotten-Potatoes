# frozen_string_literal: true

require 'rails_helper'

describe Movie do
    it 'should be able to get movies with specified ratings' do
      r_movie_search = Movie.get_movies_rated('R')
      expect(r_movie_search.rating.uniq.count).to eq(1)
      expect(r_movie_search.first.rating).to eq('R')
    end
  describe '#new' do
    it 'should understand possible ratings' do
      movie = Movie.new
      expect(movie.possible_ratings).to eq(%w[G PG PG-13 R])
    end
  end

  describe '.get_movies_rated' do
    before(:each) do
      @g_movie = Movie.create(title: 'G Movie', rating: 'G')
      @pg_movie = Movie.create(title: 'PG Movie', rating: 'PG')
      @pg13_movie = Movie.create(title: 'PG-13 Movie', rating: 'PG-13')
      @r_movie = Movie.create(title: 'R Movie', rating: 'R')
    end

    it 'should be able to get movies with specified ratings' do
      r_movie_search = Movie.get_movies_rated('R')
      expect(r_movie_search.rating.uniq.count).to eq(1)
      expect(r_movie_search.first.rating).to eq('R')
    end

    context 'when multiple ratings are provided' do
      it 'should be able to get movies with specified ratings' do
        result = Movie.get_movies_rated(['PG', 'R'])
        expect(result).to include(@pg_movie, @r_movie)
        expect(result).not_to include(@g_movie, @pg13_movie)
      end
    end

    context 'when no matching ratings are found' do
      it 'returns an empty result set' do
        result = Movie.get_movies_rated('invalid rating')
        expect(result).to be_empty
      end
    end
  end
end
