module MetricCompare
  require "yaml"

  class Repository

    def initialize
      @output_dir=MetricCompare.configuration.output_dir
    end

    def get_or_create_report(name)
      unless report_exists? name
        name = create_report(name)
      end
      get_report(name)
    end


    def get_report(name)
      YAML.load_file(@output_dir + filename(name))
    end

    def create_report(name)
      puts 'Generating report...'
      `metric_fu --format yaml --out #{filename(name)}`
    end

    def filename(name)
      "#{name}.yml"
    end

    def report_exists?(name)
      File.exists?(@output_dir + filename(name))
    end
  end
end
