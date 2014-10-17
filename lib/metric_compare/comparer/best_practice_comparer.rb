module MetricCompare

  class BestPracticeComparer < Comparer
    def initialize(old_result, new_result)
      super old_result, new_result, :rails_best_practices
    end

    def render_result
      render_header @type
      render_line("Errors",  @result[:total], @result[:total] <= 0)
    end

    def compare
      {
        total: parse_total(@old_result) - parse_total(@new_result),
      }
    end

    def parse_total(result)
      return 0 unless result
      total_string = result[:total][0]
      (/\d+/.match(total_string)[0]).to_i
    end

  end
  
end
