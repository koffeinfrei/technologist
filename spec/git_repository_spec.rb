require 'spec_helper'

describe Technologist::GitRepository do
  describe '#file_content' do
    it 'returns the content of a file in the root directory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_content('Gemfile')).not_to be_nil
    end

    it 'returns the content of a file in a subdirectory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_content('frameworks.yml')).not_to be_nil
    end
  end

  describe '#find_blob' do
    it 'does not recurse if the blob is in the root directory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository).to receive(:find_blob).once.and_call_original

      expect(repository.find_blob('Gemfile')).not_to be_nil
    end

    it 'recursively searches for the blob' do
      repository = Technologist::GitRepository.new('.')

      expect(repository).to receive(:find_blob).at_least(:twice).and_call_original

      expect(repository.find_blob('frameworks.yml')).not_to be_nil
    end
  end

  describe '#directory_exists?' do
    it 'returns true when the directory exists' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.directory_exists?('technologist')).to eq true
    end

    it 'returns false when the directory does not exist' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.directory_exists?('bogus')).to eq false
    end
  end
end
