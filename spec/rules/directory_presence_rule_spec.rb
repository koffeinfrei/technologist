require 'spec_helper'

describe DirectoryPresenceRule do
  describe '#matches?' do
    it 'returns true when the directory exists' do
      rule = DirectoryPresenceRule.new('Framework1', directory_name: 'dir1')

      repository = double(:repository)
      allow(repository).to receive(:directory_exists?).with('dir1').and_return(true)

      expect(rule.matches?(repository)).to eq true
    end
  end

  it 'returns false when the directory does not exists' do
    rule = DirectoryPresenceRule.new('Framework1', directory_name: 'dir1')

    repository = double(:repository)
    allow(repository).to receive(:directory_exists?).with('dir1').and_return(false)

    expect(rule.matches?(repository)).to eq false
  end
end
