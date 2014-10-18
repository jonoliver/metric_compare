$:.unshift File.expand_path("../metric_compare", __FILE__)
$:.unshift File.expand_path("../metric_compare/comparer", __FILE__)
$:.unshift File.expand_path("../metric_compare/repository", __FILE__)
# $:.unshift File.expand_path("../metric_compare/helpers", __FILE__)

require 'version'
require 'configuration'
require 'repository'
require 'comparer'
require 'flog_comparer'
require 'reek_comparer'
require 'best_practice_comparer'

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
