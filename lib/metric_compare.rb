require "metric_compare/version"

module MetricCompare
  def self.Init(options, args)
    repo = MetricCompare::Repository.new
    old_file = repo.get_or_create_report(args[0])
    new_file = repo.get_or_create_report(args[1])

    MetricCompare::FlogComparer.new(old_file, new_file).render_result
    MetricCompare::ReekComparer.new(old_file, new_file).render_result
    MetricCompare::BestPracticeComparer.new(old_file, new_file).render_result
  end
end

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

  end

  class FlogComparer < Comparer

    def initialize(old_file, new_file)
      super old_file, new_file, :flog
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

  class ReekComparer < Comparer

    def initialize(old_file, new_file)
      super old_file, new_file, :reek
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

  class BestPracticeComparer < Comparer
    def initialize(old_file, new_file)
      super old_file, new_file, :rails_best_practices
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

module MetricCompare
  OUTPUT_DIR='tmp/metric_fu/'
  require "yaml"

  class Repository

    def get_or_create_report(name)
      return get_report(name) if report_exists? name
      return get_report(full_git_name(name)) if git_report_exists? name
      if git_commit? name
        name = create_report_from_git(name)
      else
        create_report(name)
      end
      get_report(name)
    end

    def get_report(name)
      YAML.load_file(OUTPUT_DIR + filename(name))
    end

    def create_report(name)
      puts 'Generating report...'
      `metric_fu --format yaml --out #{filename(name)}`
    end

    def create_report_from_git(name)
      #TODO: check HEAD state, git status
      current_head = `git rev-parse --abbrev-ref HEAD`
      `git checkout #{name}`
      sha = full_git_name(name)
      create_report(sha)
      `git checkout #{current_head}`
      sha
    end

    def filename(name)
      "#{name}.yml"
    end

    def full_git_name(name)
      `git rev-parse #{name}`.strip
    end

    def report_exists?(name)
      File.exists?(OUTPUT_DIR + filename(name))
    end

    def git_commit?(name)
      `git cat-file -t #{name}`.strip == 'commit'
    end

    def git_report_exists?(name)
      puts "[DBG]: !!!"
      p git_commit?(name)
      p report_exists?(name)
      git_commit?(name) && report_exists?(full_git_name(name))
    end

  end
end
