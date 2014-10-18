require 'spec_helper'

describe 'FlogComparer' do
  before :each do
    @comparer = :flog
  end

  it 'makes a positive comparison' do
    @result1 = { total: 1, average: 2 }
    @result2 = { total: 3, average: 5 }
    expect(comparison(:total)).to eq 2
    expect(comparison(:average)).to eq 3
  end

  it 'makes a negative comparison' do
    @result1 = { total: 3, average: 5 }
    @result2 = { total: 1, average: 2 }
    expect(comparison(:total)).to eq -2
    expect(comparison(:average)).to eq -3
  end

end
