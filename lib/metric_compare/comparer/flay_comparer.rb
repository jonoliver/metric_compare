module MetricCompare
  class FlayComparer < Comparer

    def initialize(old_result, new_result)
      super old_result, new_result, :flay
    end

    def render_result
      render_header @type
      render_line("Total score",  @result[:total_score], @result[:total_score] <= 0)
    end

    def compare
      {
        total_score: @new_result[:total_score].to_i - @old_result[:total_score].to_i
      }
    end
  end
end
