require 'spec_helper'

describe 'FlayComparer' do
  before :each do
    @comparer = :flay
  end

  it 'makes a positive comparison' do
    @result1 = { total_score: '1' }
    @result2 = { total_score: '2' }
    expect(comparison(:total_score)).to eq 1
  end

  it 'makes a negative comparison' do
    @result1 = { total_score: '2' }
    @result2 = { total_score: '1' }
    expect(comparison(:total_score)).to eq -1
  end

end
