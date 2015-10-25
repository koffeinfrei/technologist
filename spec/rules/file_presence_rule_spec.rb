require 'spec_helper'

describe FilePresenceRule do
  describe '#matches?' do
    it 'returns true when the file exists' do
      rule = FilePresenceRule.new(file_name: 'file1')

      repository = double(:repository)
      allow(repository).to receive(:file_exists?).with('file1').and_return(true)

      expect(rule.matches?('Framework1', repository)).to eq true
    end
  end

  it 'returns false when the file does not exists' do
    rule = FilePresenceRule.new(file_name: 'file1')

    repository = double(:repository)
    allow(repository).to receive(:file_exists?).with('file1').and_return(false)

    expect(rule.matches?('Framework1', repository)).to eq false
  end
end
