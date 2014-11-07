require 'spec_helper'

describe 'RailsBestPracticesComparer' do
  before :each do
    @comparer = :rails_best_practices
  end

  describe 'total' do
    it 'returns nil when no results exist' do
      expect(comparison(:total)).to eq nil
    end

    it 'makes a positive comparison' do
      @result1 = { total: ["Found 1 error"] }
      @result2 = { total: ["Found 3 errors"] }
      expect(comparison(:total)).to eq 2
    end

    it 'makes a negative comparison' do
      @result1 = { total: ["Found 3 error"] }
      @result2 = { total: ["Found 1 errors"] }
      expect(comparison(:total)).to eq -2
    end

    it 'returns nil when no change' do
      @result1 = { total: ["Found 1 error"] }
      @result2 = { total: ["Found 1 errors"] }
      expect(comparison(:total)).to eq nil
    end

  end

end
