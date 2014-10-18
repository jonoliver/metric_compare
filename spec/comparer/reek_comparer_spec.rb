require 'spec_helper'

describe 'ReekComparer' do
  before :each do
    @comparer = :reek
  end

  it 'makes a positive comparison' do
    @result1 = { matches: [code_smells: []] }
    @result2 = { matches: [code_smells: [0,0]] }
    expect(comparison(:total)).to eq 2
  end

  it 'makes a negative comparison' do
    @result1 = { matches: [code_smells: [0,0]] }
    @result2 = { matches: [code_smells: []] }
    expect(comparison(:total)).to eq -2
  end

end
