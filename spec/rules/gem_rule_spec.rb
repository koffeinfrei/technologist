require 'spec_helper'

describe GemRule do
  describe '#matches?' do
    it 'returns true when the Gemfile contains the explicitely defined gem name' do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem 'next_generation_gem'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns true when the Gemfile contains the inferred gem name' do
      rule = GemRule.new

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem 'framework1'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns true when the gem name is in double quotes' do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem \"next_generation_gem\"\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns true when the gem name is in single quotes' do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem 'next_generation_gem'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it 'returns true when the gem is specified with a version' do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem 'next_generation_gem', '~> 4.3'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it "returns true when the gem definition is indented" do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\n  gem 'next_generation_gem'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq true
    end

    it "returns false when the gem is commented out" do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\n# gem 'next_generation_gem'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq false
    end

    it 'returns false when the Gemfile does not contain the gem' do
      rule = GemRule.new(gem_name: 'next_generation_gem')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('Gemfile')
        .and_yield("content\ngem 'last_generation_gem'\ncontent")

      expect(rule.matches?('Framework1', repository)).to eq false
    end
  end
end
