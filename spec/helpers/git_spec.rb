require_relative '../../lib/metric_compare/helpers/git.rb'

describe MetricCompare::Git do
  it 'gets the sha of the current head' do
    expect(MetricCompare::Git).to receive(:commit_hash_for_step).with(no_args).and_return 'sha0'
    expect(MetricCompare::Git.head).to eq 'sha0'
  end  

  it 'gets the sha of the previous commit' do
    expect(MetricCompare::Git).to receive(:commit_hash_for_step).with(1).and_return 'sha1'
    expect(MetricCompare::Git.last_commit).to eq 'sha1'
  end
end
