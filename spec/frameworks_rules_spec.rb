require 'spec_helper'

describe 'Frameworks rules' do
  describe 'Locomotive' do
    it 'returns Locomotive' do
      repository = repository('Gemfile', "bogus\ngem 'locomotivecms_wagon'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Locomotive']
    end
  end

  describe 'Rails' do
    it 'returns Rails' do
      repository = repository('Gemfile', "bogus\ngem 'rails'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Rails when specified with version' do
      repository = repository('Gemfile', "bogus\ngem 'rails', '~> 4.3'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
    end

    it 'returns Rails when indented' do
      repository = repository('Gemfile', "bogus\n  gem 'rails'\nbogus")
      expect(repository.primary_frameworks).to eq ['Rails']
    end

    it 'does not return Rails when commented out' do
      repository = repository('Gemfile', "bogus\n# gem 'rails'\nbogus")
      expect(repository.primary_frameworks).to_not eq ['Rails']
    end
  end

  describe 'Magnolia' do
    it 'returns Magnolia' do
      repository = repository('pom.xml', "bogus\n    <magnoliaVersion>    \nbogus")
      expect(repository.primary_frameworks).to eq ['Magnolia']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Sinatra' do
    it 'returns Sinatra (1)' do
      repository = repository('config.ru', "bogus\nrun Sinatra::Application\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Sinatra (2)' do
      repository = repository('Gemfile', "bogus\ngem 'sinatra'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Sinatra when specified with version' do
      repository = repository('Gemfile', "bogus\ngem 'sinatra', '~> 4.3'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'returns Sinatra when indented' do
      repository = repository('Gemfile', "bogus\n  gem 'sinatra'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'does not return Sinatra when commented out' do
      repository = repository('Gemfile', "bogus\n# gem 'sinatra'\nbogus")
      expect(repository.primary_frameworks).to_not eq ['Sinatra']
    end
  end

  describe 'Dashing' do
    it 'returns Dashing' do
      repository = repository('Gemfile', "bogus\ngem 'dashing'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq ['Dashing']
    end

    it 'returns Sinatra when specified with version' do
      repository = repository('Gemfile', "bogus\ngem 'dashing', '~> 4.3'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'returns Sinatra when indented' do
      repository = repository('Gemfile', "bogus\n  gem 'dashing'\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'does not return Sinatra when commented out' do
      repository = repository('Gemfile', "bogus\n# gem 'dashing'\nbogus")
      expect(repository.primary_frameworks).to_not eq ['Sinatra']
    end
  end

  describe 'Middleman' do
    it 'returns Middleman' do
      repository = repository('Gemfile', "bogus\ngem 'middleman'\nbogus")
      expect(repository.primary_frameworks).to eq ['Middleman']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Middleman when specified with version' do
      repository = repository('Gemfile', "bogus\ngem 'middleman', '~> 4.3'\nbogus")
      expect(repository.primary_frameworks).to eq ['Middleman']
    end

    it 'returns Middleman when indented' do
      repository = repository('Gemfile', "bogus\n  gem 'middleman'\nbogus")
      expect(repository.primary_frameworks).to eq ['Middleman']
    end

    it 'does not return Middleman when commented out' do
      repository = repository('Gemfile', "bogus\n# gem 'middleman'\nbogus")
      expect(repository.primary_frameworks).to_not eq ['Middleman']
    end
  end

  def repository(file_name, file_content)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:file_content).and_return(nil)

      allow(repository.git_repository).to receive(:file_content).with(file_name).and_return(file_content)
    end
  end
end
