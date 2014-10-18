module MetricCompare

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    configuration.tap do |config|
      # config.configure_metrics
    end
  end

  class Configuration
    attr_accessor :output_dir
  end
end
