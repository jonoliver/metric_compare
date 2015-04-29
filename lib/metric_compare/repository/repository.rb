module MetricCompare
  require "yaml"

  class Repository
    include Git
    
    def initialize
      @output_dir=MetricCompare.configuration.output_dir
    end

    def get_or_create_report(name)
      return get_report(name) if report_exists? name
      return get_report(Git.full_commit_hash(name)) if git_report_exists? name
      if Git.commit? name
        name = create_report_from_git(name)
      else
        create_report(name)
      end
      get_report(name)
    end

    def get_report(name)
      YAML.load_file(@output_dir + filename(name))
    end

    def create_report(name)
      puts "Generating report for #{name}..."
      `metric_fu --format yaml --out #{filename(name)}`
    end

    def create_report_from_git(name)
      abort 'Make sure your git status is clean before running a comparison' unless Git.clean?
      current_head = Git.head_short_name
      Git.checkout name
      sha = Git.full_commit_hash(name)
      create_report(sha)
      Git.checkout current_head
      sha
    end

    def filename(name)
      "#{name}.yml"
    end

    def report_exists?(name)
      File.exists?(@output_dir + filename(name))
    end

    def git_report_exists?(name)
      Git.commit?(name) && report_exists?(Git.full_commit_hash(name))
    end

  end
end
