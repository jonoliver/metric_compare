module MetricCompare

  class BestPracticeComparer < Comparer
    def initialize(old_result, new_result)
      super old_result, new_result, :rails_best_practices
    end

    def render_result
      if total
        render_header @type
        render_line("Errors",  @result[:total], @result[:total] <= 0)
      end
    end

    def compare
      {
        total: total,
      }
    end

    private

    def total
      total = parse_total(@new_result) - parse_total(@old_result)
      (total == 0) ? nil : total
    end

    def parse_total(result)
      return 0 unless result
      total_string = result[:total][0]
      (/\d+/.match(total_string)[0]).to_i
    end

  end

end
