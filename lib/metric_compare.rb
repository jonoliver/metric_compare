Gem.find_files("metric_compare/helpers/*.rb").each { |path| require path }
Gem.find_files("metric_compare/*.rb").each { |path| require path }
Gem.find_files("metric_compare/**/*.rb").each { |path| require path }

module MetricCompare
  def self.Init(options, args)
    reports = self.get_reports args

    MetricCompare::FlogComparer.new(reports[0], reports[1]).render_result
    MetricCompare::ReekComparer.new(reports[0], reports[1]).render_result
    MetricCompare::CaneComparer.new(reports[0], reports[1]).render_result
    MetricCompare::RailsBestPracticesComparer.new(reports[0], reports[1]).render_result
  end
  
  # returns an array of reports: [old_report, new_report]
  def self.get_reports args_array
    include MetricCompare::Git
    repo = MetricCompare::Repository.new
    reports = []
    
    case args_array.size
    # No arguments: Compare current HEAD to last commit
    when 0
      reports << repo.get_or_create_report(Git.last_commit)
      reports << repo.get_or_create_report(Git.head)
    # One argument: Compare current HEAD to argument  
    when 1
      reports << repo.get_or_create_report(Git.last_commit)
      reports << repo.get_or_create_report(args_array[0])
    # Two arguments: Compare both arguments (using priority searching)  
    when 2
      reports << repo.get_or_create_report(args_array[0])
      reports << repo.get_or_create_report(args_array[1])
    # No more than two arguments accepted  
    else
      raise 'Only two reports may be specified'
    end
    
    reports
  end
end