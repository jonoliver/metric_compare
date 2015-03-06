require 'metric_compare'

MetricCompare.configuration.output_dir='spec/fixtures/'

#TODO: get this out of here
class Symbol
  def to_class_name
    self.to_s.split("_").map{|word| word.capitalize}.join
  end
end

private

def comparison(property=nil)
  result = init_comparer(result(@result1), result(@result2))
  property.nil? ? result : result[property]
end

def result(result)
  {
    @comparer => result
  }
end

def init_comparer(result1, result2)
  comparer = Object.const_get("MetricCompare::#{@comparer.to_class_name}Comparer")
  comparer.new(result1, result2).compare
end
