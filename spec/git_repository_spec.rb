require 'spec_helper'

describe Technologist::GitRepository do
  describe '#find_blob' do
    context 'non-recursive lookup' do
      it 'does not recurse if the blob is in the root directory' do
        repository = Technologist::GitRepository.new('.')

        expect(repository).to receive(:find_blob).once.and_call_original

        expect(repository.find_blob('Gemfile')).to be_an_instance_of Rugged::Blob
      end

      it 'yields to the block when a file is found and a block is provided' do
        repository = Technologist::GitRepository.new('.')

        expect(repository).to receive(:find_blob).once.and_call_original

        yielded_value = nil
        repository.find_blob('Gemfile') do |blob|
          yielded_value = blob
        end
        expect(yielded_value).to be_an_instance_of Rugged::Blob
      end
    end

    context 'recursive lookup' do
      it 'recursively searches for the blob' do
        repository = Technologist::GitRepository.new('.')

        expect(repository).to receive(:find_blob).at_least(:twice).and_call_original

        expect(repository.find_blob('frameworks.yml')).to be_an_instance_of Rugged::Blob
      end

      it 'yields to the block when a file is found and a block is provided' do
        repository = Technologist::GitRepository.new('.')

        expect(repository).to receive(:find_blob).at_least(:twice).and_call_original

        yielded_value = nil
        repository.find_blob('frameworks.yml') do |blob|
          yielded_value = blob
        end
        expect(yielded_value).to be_an_instance_of Rugged::Blob
      end
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

  describe '#file_exists?' do
    it 'returns true when the file exists' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_exists?('Gemfile')).to eq true
    end

    it 'returns false when the file does not exist' do
      repository = Technologist::GitRepository.new('.')

      expect(repository.file_exists?('bogus')).to eq false
    end
  end

  describe '#file_with_content_exists?' do
    it 'returns true when the file exists and the block evualtes to true' do
      repository = Technologist::GitRepository.new('.')

      exists = repository.file_with_content_exists?('Gemfile') do |content|
        true
      end

      expect(exists).to eq true
    end

    it 'returns true when the file exists twice and the block evualtes to false the first time and true the second time' do
      repository = Technologist::GitRepository.new('.')
      file1 = double(:file1, content: 'content1')
      file2 = double(:file2, content: 'content2')
      allow(repository).to receive(:find_blob).with('virtual_file')
        .and_yield(file1)
        .and_yield(file2)

      exists = repository.file_with_content_exists?('virtual_file') do |content|
        content == 'content2'
      end

      expect(exists).to eq true
    end

    it 'returns false when the file exists but the block evaluates to false' do
      repository = Technologist::GitRepository.new('.')

      exists = repository.file_with_content_exists?('Gemfile') do |content|
        false
      end

      expect(exists).to eq false
    end

    it 'returns false when the file does not exist' do
      repository = Technologist::GitRepository.new('.')

      exists = repository.file_with_content_exists?('bogus') do |content|
        true
      end

      expect(exists).to eq false
    end
  end
end
