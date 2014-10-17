require 'spec_helper'

describe 'ReekComparer' do

  it 'makes a positive comparison' do
    result1 = reek_result({ matches: [code_smells: []] })
    result2 = reek_result({ matches: [code_smells: [0,0]] })
    comparison = MetricCompare::ReekComparer.new(result1, result2).compare
    expect(comparison[:total]).to eq 2
  end

  it 'makes a negative comparison' do
    result1 = reek_result({ matches: [code_smells: [0,0]] })
    result2 = reek_result({ matches: [code_smells: []] })
    comparison = MetricCompare::ReekComparer.new(result1, result2).compare
    expect(comparison[:total]).to eq -2
  end

  def reek_result(result)
    {
      reek: result
    }
  end
end
