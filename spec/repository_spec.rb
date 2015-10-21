require 'spec_helper'

describe Technologist::Repository do
  let(:repository) do
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:file_content).and_return(nil)

      # rules
      allow(repository.framework_detector).to receive(:rules).and_return({
        'SecondaryFramework' => {
          'rules' => [
            { 'file1' => 'file1_content' },
          ],
          'primary' => 'PrimaryFramework'
        }
      })
    end
  end

  describe '#primary_frameworks' do
    it 'returns Dashing' do
      allow(repository.git_repository).to receive(:file_content).with('file1').and_return("file1_content")

      expect(repository.primary_frameworks).to eq ['PrimaryFramework']
    end
  end

  describe '#secondary_frameworks' do
    it 'returns Dashing' do
      allow(repository.git_repository).to receive(:file_content).with('file1').and_return("file1_content")

      expect(repository.secondary_frameworks).to eq ['SecondaryFramework']
    end
  end
end
