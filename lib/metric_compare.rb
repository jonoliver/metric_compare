require "metric_compare/version"
require "yaml"
require "colorize"

module MetricCompare
  module Renderable

    def render_header(type)
      puts ""
      puts "#{type} result:".yellow
    end

    def render_line(title, value, condition)
      puts "#{title}\t#{color(condition, format_value(value))}"
    end

    def format_value(value)
      (value > 0) ? "+#{value}" : "#{value}"
    end

    def color(condition, value)
      value = value.to_s
      condition ? value.green : value.red
    end
  end

end

module MetricCompare

  class Comparer
    include Renderable
    attr_reader :old_result, :new_result

    def initialize(old_file, new_file, type)
      @old_result = YAML.load_file(old_file)[type]
      @new_result = YAML.load_file(new_file)[type]
      @type = type
      @result = compare
    end

    def compare
      raise 'Implemented by child class'
    end

  end

  class FlogComparer < Comparer

    def initialize(old_file, new_file)
      super old_file, new_file, :flog
    end

    def render_result
      render_header @type
      render_line("Total",  @result[:total], @result[:total] < 0)
      render_line("Average",  @result[:average], @result[:average] < 0)
    end

    def compare
      {
        total: @old_result[:total] - @new_result[:total],
        average: @old_result[:average] - @new_result[:average],
      }
    end
  end

  class ReekComparer < Comparer

    def initialize(old_file, new_file)
      super old_file, new_file, :reek
    end

    def render_result
      render_header @type
      render_line("Code smells",  @result[:total], @result[:total] < 0)
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

  class BestPracticeComparer < Comparer
    def initialize(old_file, new_file)
      super old_file, new_file, :rails_best_practices
    end

    def render_result
      render_header @type
      render_line("Errors",  @result[:total], @result[:total] < 0)
    end

    def compare
      {
        total: parse_total(@old_result) - parse_total(@new_result),
      }
    end

    def parse_total(result)
      total_string = result[:total][0]
      (/\d+/.match(total_string)[0]).to_i
    end

  end

end
