require 'metric_compare'

describe 'FlogComparer' do
  it 'makes a comparison' do
    comparison = MetricCompare::FlogComparer.new('report.yml', 'custom_report.yml')
    comparison.render_result
  end
end
describe 'ReekComparer' do
  it 'makes a comparison' do
    comparison = MetricCompare::ReekComparer.new('report.yml', 'custom_report.yml')
    comparison.render_result
  end
end
describe 'BestPracticeComparer' do
  it 'makes a comparison' do
    comparison = MetricCompare::BestPracticeComparer.new('report.yml', 'custom_report.yml')
    comparison.render_result
  end
end
