module MetricCompare
  class StatsComparer < Comparer
    
    def initialize(old_result, new_result)
      super old_result, new_result, :stats
    end

    def render_result
      render_header @type
      render_line("Code to test ratio 1:#{@new_result[:code_to_test_ratio]}",  @result[:code_to_test_ratio], @result[:code_to_test_ratio] >= 0)
    end

    def compare
      {
        code_to_test_ratio: (@new_result[:code_to_test_ratio] - @old_result[:code_to_test_ratio]).round(5)
      }
    end
  end
end
