require 'metric_compare'

describe 'Init' do
  it 'makes a comparison' do
    MetricCompare::Init({}, ['report', 'custom_report'])
  end
end
