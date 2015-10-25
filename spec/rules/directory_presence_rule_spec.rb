require 'spec_helper'

describe DirectoryPresenceRule do
  describe '#matches?' do
    it 'returns true when the directy exists' do
      rule = DirectoryPresenceRule.new(directory_name: 'dir1')

      repository = double(:repository)
      allow(repository).to receive(:directory_exists?).with('dir1').and_return(true)

      expect(rule.matches?('Framework1', repository)).to eq true
    end
  end

  it 'returns false when the directy does not exists' do
    rule = DirectoryPresenceRule.new(directory_name: 'dir1')

    repository = double(:repository)
    allow(repository).to receive(:directory_exists?).with('dir1').and_return(false)

    expect(rule.matches?('Framework1', repository)).to eq false
  end
end
