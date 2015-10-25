require 'spec_helper'

describe FileContentRule do
  describe '#matches?' do
    it 'returns true when the file contains the string' do
      rule = FileContentRule.new(file_name: 'file1', file_content_pattern: 'content1')

      repository = double(:repository)
      allow(repository).to receive(:file_content).with('file1').and_return('content1')

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns true when the file contains the pattern' do
      rule = FileContentRule.new(file_name: 'file1', file_content_pattern: /content\d/)

      repository = double(:repository)
      allow(repository).to receive(:file_content).with('file1').and_return('content1')

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns false when the file does not contain the string' do
      rule = FileContentRule.new(file_name: 'file1', file_content_pattern: 'content1')

      repository = double(:repository)
      allow(repository).to receive(:file_content).with('file1').and_return('bogus')

      expect(rule.matches?('Framework1', repository)).to eq false
    end
  end
end
