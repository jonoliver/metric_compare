require 'spec_helper'

describe 'Init' do
  it 'makes a comparison' do
    MetricCompare::Init({}, ['report_1', 'report_2'])
  end
end
