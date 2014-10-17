module MetricCompare
  class FlogComparer < Comparer

    def initialize(old_result, new_result)
      super old_result, new_result, :flog
    end

    def render_result
      render_header @type
      render_line("Total",  @result[:total], @result[:total] <= 0)
      render_line("Average",  @result[:average], @result[:average] <= 0)
    end

    def compare
      {
        total: @new_result[:total] - @old_result[:total],
        average: @new_result[:average] - @old_result[:average],
      }
    end
  end
end
