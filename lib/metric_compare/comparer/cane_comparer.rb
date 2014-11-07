module MetricCompare
  class CaneComparer < Comparer

    def initialize(old_result, new_result)
      super old_result, new_result, :cane
    end

    def render_result
      render_header @type
      puts "[DBG]: @result #{@result}"
      abc_complexity = @result[:abc_complexity][:total]
      render_line("Total",  abc_complexity, abc_complexity <= 0)
    end

    def compare
      return nil if @old_result == nil && @new_result == nil
      {
        abc_complexity: {
          total: abc_complexity_total
        }
      }
    end

    private

    def abc_complexity_total
      old1 =  @old_result[:violations][:abc_complexity]
      new1 = @new_result[:violations][:abc_complexity]
      puts "[DBG]: !!!"
      p old1
      p new1
      return 0 if old1 == new1
      diff1 = diff_complexity(old1, new1)
      diff2 = diff_complexity(new1, old1)
      diff1.reject{|k,v| v < 0}.keys.size - diff2.reject{|k,v| v < 0}.keys.size
    end

    def diff_complexity(result1, result2)
      output = {}
      result1.each do |result|
        match = result2.first{|element| element[:file] == result[:file] && element[:method] == result[:method]}
        output["#{match[:file]}:#{match[:method]}"] = match[:complexity].to_f - result[:complexity].to_f
      end
      output
    end
  end
end
