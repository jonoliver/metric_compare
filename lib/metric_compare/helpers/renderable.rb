module MetricCompare

  require "colorize"

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
