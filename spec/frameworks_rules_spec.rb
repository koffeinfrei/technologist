require 'spec_helper'

describe 'Frameworks rules' do
  describe 'Locomotive' do
    it 'returns Dashing' do
      repository = repository('Gemfile', "bogus\ngem 'locomotivecms_wagon'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Locomotive']
    end

    it 'returns Rails' do
      repository = repository('Gemfile', "bogus\ngem 'rails'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Magnolia' do
      repository = repository('pom.xml', "bogus\n    <magnoliaVersion>    \nbogus")
      expect(repository.primary_frameworks).to eq ['Magnolia']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Sinatra' do
      repository = repository('config.ru', "bogus\nrun Sinatra::Application\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Dashing' do
      repository = repository('Gemfile', "bogus\ngem 'dashing'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq ['Dashing']
    end

    it 'returns Middleman' do
      repository = repository('Gemfile', "bogus\ngem 'middleman'\nbogus")
      expect(repository.primary_frameworks).to eq ['Middleman']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  def repository(file_name, file_content)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository).to receive(:file_content).and_return(nil)

      allow(repository).to receive(:file_content).with(file_name).and_return(file_content)
    end
  end
end
