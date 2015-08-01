module MetricCompare
  class SaikuroComparer < Comparer
    
    def initialize(old_result, new_result)
      super old_result, new_result, :saikuro
    end

    def render_result
      render_header @type
      render_line("Complexity",nil,nil)
      @result.each do |key, val|
        render_line(key,  val, val <= 0)
      end
    end

    def compare
      old_complexity = class_complexity @old_result
      new_complexity = class_complexity @new_result
      compare_complexity old_complexity, new_complexity
    end
    
    private
    
    def class_complexity report
      result = {}
      report[:classes].each do |klass|
        unless klass[:name].empty?
          result[klass[:name]] = klass[:complexity]
        end
      end
      result
    end
    
    def compare_complexity old_comp, new_comp
      result = {}
      old_comp.keys.each do |klass|
        old_val = old_comp[klass] || 0
        new_val = new_comp[klass] || 0
        result[klass] = (new_val - old_val) unless old_val == new_val
      end
      result
    end
  end
end
