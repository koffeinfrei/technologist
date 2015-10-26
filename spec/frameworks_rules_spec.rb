require 'spec_helper'

RSpec.describe 'Frameworks rules' do
  describe 'Rails' do
    it 'returns Rails' do
      repository = create_repository_with_file_content('Gemfile', "gem 'rails'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Locomotive' do
    it 'returns Rails as primary and Locomotive as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'locomotivecms_wagon'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Locomotive']
    end
  end

  describe 'Magnolia' do
    it 'returns Magnolia' do
      repository = create_repository_with_file_content('pom.xml', "bogus\n    <magnoliaVersion>    \nbogus")
      expect(repository.primary_frameworks).to eq ['Magnolia']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Sinatra' do
    it 'returns Sinatra when the config.ru file rule matches' do
      repository = create_repository_with_file_content('config.ru', "bogus\nrun Sinatra::Application\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'returns Sinatra when the gem file rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'sinatra'")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Dashing' do
    it 'returns Sinatra as primary and Dashing as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'dashing'")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq ['Dashing']
    end
  end

  describe 'Middleman' do
    it 'returns Middleman' do
      repository = create_repository_with_file_content('Gemfile', "gem 'middleman'")
      expect(repository.primary_frameworks).to eq ['Middleman']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Meteor' do
    it 'returns Meteor' do
      repository = create_repository_with_directory('.meteor')
      expect(repository.primary_frameworks).to eq ['Meteor']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Locomotive' do
    it 'returns Rails as primary and Spree as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'spree'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Spree']
    end
  end

  describe 'Wordpress' do
    it 'returns Wordpress' do
      repository = create_repository_with_file('wp-settings.php')
      expect(repository.primary_frameworks).to eq ['Wordpress']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Volt' do
    it 'returns Volt' do
      repository = create_repository_with_file_content('Gemfile', "gem 'volt'")
      expect(repository.primary_frameworks).to eq ['Volt']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Ionic' do
    it 'returns Ionic' do
      repository = create_repository_with_file('ionic.project')
      expect(repository.primary_frameworks).to eq ['Ionic']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Node' do
    it 'returns Node' do
      repository = create_repository_with_file_content('package.json', %[
        "engines": {
          "node": ">=0.10.22"
         }
      ])
      expect(repository.primary_frameworks).to eq ['Node']
      expect(repository.secondary_frameworks).to eq []
    end
  end
end
