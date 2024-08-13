# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'


describe Movie do
  it 'should understand possible ratings' do
    expect(Movie.possible_ratings).to eq(%w[G PG PG-13 R])
  end
end
