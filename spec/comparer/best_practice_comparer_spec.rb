require 'spec_helper'

describe 'BestPracticeComparer' do
  describe 'total' do
    it 'returns 0 when no results exist' do
      comparison = MetricCompare::BestPracticeComparer.new({},{}).compare
      expect(comparison[:total]).to eq nil
    end

    it 'makes a positive comparison' do
      result1 = result({ total: ["Found 1 error"] })
      result2 = result({ total: ["Found 3 errors"] })
      comparison = MetricCompare::BestPracticeComparer.new(result1, result2).compare
      expect(comparison[:total]).to eq 2
    end

    it 'makes a negative comparison' do
      result1 = result({ total: ["Found 3 error"] })
      result2 = result({ total: ["Found 1 errors"] })
      comparison = MetricCompare::BestPracticeComparer.new(result1, result2).compare
      expect(comparison[:total]).to eq -2
    end

    it 'returns nil when no change' do
      result1 = result({ total: ["Found 1 error"] })
      result2 = result({ total: ["Found 1 errors"] })
      comparison = MetricCompare::BestPracticeComparer.new(result1, result2).compare
      expect(comparison[:total]).to eq nil
    end

  end
  def result(result)
    {
      rails_best_practices: result
    }
  end
end
