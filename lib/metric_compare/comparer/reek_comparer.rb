module MetricCompare

  class ReekComparer < Comparer

    def initialize(old_result, new_result)
      super old_result, new_result, :reek
    end

    def render_result
      render_header @type
      render_line("Code smells",  @result[:total], @result[:total] <= 0)
    end

    def compare
      {
        total: total_smells(@old_result) - total_smells(@new_result),
      }
    end

    def total_smells(result)
      total = 0
      result[:matches].each do |match|
        total += match[:code_smells].count
      end
      total
    end
  end
end
