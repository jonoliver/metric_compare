require 'spec_helper'

describe 'FlogComparer' do
  it 'makes a comparison' do
    result1 = {
      flog: {
        total: 0,
        average: 0,
      }
    }

    result2 = {
      flog: {
        total: 1,
        average: 5,
      }
    }

    comparison = MetricCompare::FlogComparer.new(result1, result2)
    p comparison.compare
    # comparison.render_result
  end
end
