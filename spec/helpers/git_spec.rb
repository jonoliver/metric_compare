require_relative '../../lib/metric_compare/helpers/git.rb'

describe Git do
  it 'gets the sha of the current head' do
    expect(Git).to receive(:commit_hash_for_step).with(no_args).and_return 'sha0'
    expect(Git.head).to eq 'sha0'
  end  

  it 'gets the sha of the previous commit' do
    expect(Git).to receive(:commit_hash_for_step).with(1).and_return 'sha1'
    expect(Git.last_commit).to eq 'sha1'
  end  

end
