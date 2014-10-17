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
