require 'spec_helper'

describe 'Init' do
  it 'makes a comparison' do
    MetricCompare::Init({}, ['report_1', 'report_2'])
  end
end

describe 'get_reports' do
  # TODO: write a real test
  it 'gets some reports' do
    repo = double(:repo)
    expect(MetricCompare::Repository).to receive(:new).and_return(repo)
    expect(repo).to receive(:get_or_create_report).twice
    MetricCompare.get_reports []
  end
end