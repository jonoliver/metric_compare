require 'spec_helper'

describe 'SaikuroComparer' do
  before :each do
    @comparer = :saikuro
  end
  
  describe 'complexity' do
    it 'makes a positive comparison' do
      @result1 = { classes: [{name: "ClassName", complexity: 1}] }
      @result2 = { classes: [{name: "ClassName", complexity: 5}] }
      expect(comparison("ClassName")).to eq 4
    end

    it 'makes a negative comparison' do
      @result1 = { classes: [{name: "ClassName", complexity: 5}] }
      @result2 = { classes: [{name: "ClassName", complexity: 1}] }
      expect(comparison("ClassName")).to eq -4
    end
  end
end
