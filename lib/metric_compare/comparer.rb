module MetricCompare

  class Comparer
    include Renderable
    attr_reader :old_result, :new_result

    def initialize(old_result, new_result, type)
      @old_result = old_result[type]
      @new_result = new_result[type]
      @type = type
      @result = compare
    end

    def compare
      raise 'Implemented by child class'
    end

    def render_result
      raise 'Implemented by child class'
    end

  end
end
