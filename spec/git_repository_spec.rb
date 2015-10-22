require 'spec_helper'

describe Technologist::GitRepository do
  context '#file_content' do
    it 'returns the content of a file in the root directory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_content('Gemfile')).not_to be_nil
    end

    it 'returns the content of a file in a subdirectory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_content('frameworks.yml')).not_to be_nil
    end
  end

  context '#find_file' do
    it 'does not recurse if the file is in the root directory' do
      repository = Technologist::GitRepository.new('.')

      expect(repository).to receive(:find_file).once.and_call_original

      expect(repository.find_file('Gemfile')).not_to be_nil
    end

    it 'recursively searches for the file' do
      repository = Technologist::GitRepository.new('.')

      expect(repository).to receive(:find_file).at_least(:twice).and_call_original

      expect(repository.file_content('frameworks.yml')).not_to be_nil
    end
  end
end
