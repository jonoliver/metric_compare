require 'spec_helper'

describe 'StatsComparer' do
  before :each do
    @comparer = :stats
  end

  it 'makes a positive comparison' do
    @result1 = { code_to_test_ratio: 1.1 }
    @result2 = { code_to_test_ratio: 1.5 }
    expect(comparison(:code_to_test_ratio)).to eq 0.4
  end

  it 'makes a negative comparison' do
    @result1 = { code_to_test_ratio: 1.5 }
    @result2 = { code_to_test_ratio: 1.1 }
    expect(comparison(:code_to_test_ratio)).to eq -0.4
  end

end
