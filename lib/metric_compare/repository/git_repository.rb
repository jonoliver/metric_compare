module MetricCompare
  class GitRepository
    def initialize repository
      @repository = repository
    end

    def get_or_create_report(name)
      return @repository.get_report(name) if @repository.report_exists? name
      return @repository.get_report(full_git_name(name)) if report_exists? name
      if git_commit? name
        name = create_report(name)
      else
        @repository.create_report(name)
      end
      @repository.get_or_create_report(name)
    end

    def full_git_name(name)
      `git rev-parse #{name}`.strip
    end

    def git_commit?(name)
      `git cat-file -t #{name}`.strip == 'commit'
    end

    def report_exists?(name)
      git_commit?(name) && @repository.report_exists?(full_git_name(name))
    end

    def create_report(name)
      #TODO: check HEAD state, git status
      current_head = `git rev-parse --abbrev-ref HEAD`
      `git checkout #{name}`
      sha = full_git_name(name)
      @repository.create_report(sha)
      `git checkout #{current_head}`
      sha
    end

  end
end
