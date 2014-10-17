require 'spec_helper'

describe 'FlogComparer' do

  it 'makes a positive comparison' do
    result1 = flog_result({ total: 1, average: 2 })
    result2 = flog_result({ total: 3, average: 5 })
    comparison = MetricCompare::FlogComparer.new(result1, result2).compare
    expect(comparison[:total]).to eq 2
    expect(comparison[:average]).to eq 3
  end

  it 'makes a negative comparison' do
    result1 = flog_result({ total: 3, average: 5 })
    result2 = flog_result({ total: 1, average: 2 })
    comparison = MetricCompare::FlogComparer.new(result1, result2).compare
    expect(comparison[:total]).to eq -2
    expect(comparison[:average]).to eq -3
  end

  def flog_result(result)
    {
      flog: result
    }
  end
end
