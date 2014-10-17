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
        total: @old_result[:total] - @new_result[:total],
        average: @old_result[:average] - @new_result[:average],
      }
    end
  end
end
