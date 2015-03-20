Gem.find_files("metric_compare/helpers/*.rb").each { |path| require path }
Gem.find_files("metric_compare/*.rb").each { |path| require path }
Gem.find_files("metric_compare/**/*.rb").each { |path| require path }

module MetricCompare
  def self.Init(options, args)
    repo = MetricCompare::Repository.new
    old_file = repo.get_or_create_report(args[0])
    new_file = repo.get_or_create_report(args[1])

    MetricCompare::FlogComparer.new(old_file, new_file).render_result
    MetricCompare::ReekComparer.new(old_file, new_file).render_result
    MetricCompare::CaneComparer.new(old_file, new_file).render_result
    MetricCompare::RailsBestPracticesComparer.new(old_file, new_file).render_result
  end
end
