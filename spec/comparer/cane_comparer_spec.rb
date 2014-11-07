require 'spec_helper'

describe 'CaneComparer' do
  before :each do
    @comparer = :cane
  end

  describe 'total' do
    it 'returns nil if no violations are found' do
      expect(comparison()).to eq nil
    end

    it 'returns no difference' do
      @result1 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      @result2 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      expect(comparison(:abc_complexity)[:total]).to eq 0
    end


    it 'makes a positive comparison' do
      @result1 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      @result2 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 20]
      expect(comparison(:abc_complexity)[:total]).to eq 1
    end

    it 'makes a negative comparison' do
      @result1 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 20]
      @result2 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      expect(comparison(:abc_complexity)[:total]).to eq -1
    end

    it 'needs a better test name' do
      @result1 = abc_wrap [
        { file: 'wat_file', method: 'wat_method', complexity: 20 },
        { file: 'wat_file', method: 'wat_method2', complexity: 20 },
      ]
      @result2 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      expect(comparison(:abc_complexity)[:total]).to eq -2
    end
    it 'needs a better test name' do
      @result1 = abc_wrap [file: 'wat_file', method: 'wat_method', complexity: 10]
      @result2 = abc_wrap [
        { file: 'wat_file', method: 'wat_method', complexity: 20 },
        { file: 'wat_file', method: 'wat_method2', complexity: 20 },
      ]
      expect(comparison(:abc_complexity)[:total]).to eq 2
    end

  end

  private

  def abc_wrap(violations)
    {violations: {
      abc_complexity: violations
    }}
  end

end

# :cane:
#   :total_violations: 231
#   :violations:
#     :abc_complexity:
#     - :file: app/controllers/concerns/current_cart.rb
#       :method: CurrentCart#set_cart
#       :complexity: '22'
