require 'spec_helper'

describe FileContentRule do
  describe '#matches?' do
    it 'returns true when the file contains the string' do
      rule = FileContentRule.new('Framework1', file_name: 'file1', file_content_pattern: 'content1')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('file1').and_yield('content1')

      expect(rule.matches?(repository)).to eq true
    end

    it 'returns true when the file contains the pattern' do
      rule = FileContentRule.new('Framework1', file_name: 'file1', file_content_pattern: /content\d/)

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('file1').and_yield('content1')

      expect(rule.matches?(repository)).to eq true
    end

    it 'returns false when the file does not contain the string' do
      rule = FileContentRule.new('Framework1', file_name: 'file1', file_content_pattern: 'content1')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('file1').and_yield('bogus')

      expect(rule.matches?(repository)).to eq false
    end
  end
end
