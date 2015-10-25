require 'spec_helper'
require 'support/shared_examples_for_framework_rules'

RSpec.describe 'Frameworks rules' do
  describe 'Rails' do
    it_behaves_like 'gem rule', 'Rails', 'rails'
  end

  describe 'Locomotive' do
    it 'returns Locomotive as secondary' do
      repository = create_repository('Gemfile', "gem 'locomotivecms_wagon'")
      expect(repository.secondary_frameworks).to eq ['Locomotive']
    end

    it_behaves_like 'gem rule', 'Rails', 'locomotivecms_wagon'
  end

  describe 'Magnolia' do
    it 'returns Magnolia' do
      repository = create_repository('pom.xml', "bogus\n    <magnoliaVersion>    \nbogus")
      expect(repository.primary_frameworks).to eq ['Magnolia']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Sinatra' do
    it 'returns Sinatra when the config.ru file rule matches' do
      repository = create_repository('config.ru', "bogus\nrun Sinatra::Application\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it_behaves_like 'gem rule', 'Sinatra', 'sinatra'
  end

  describe 'Dashing' do
    it 'returns Dashing as secondary' do
      repository = create_repository('Gemfile', "gem 'dashing'")
      expect(repository.secondary_frameworks).to eq ['Dashing']
    end

    it_behaves_like 'gem rule', 'Sinatra', 'dashing'
  end

  describe 'Middleman' do
    it_behaves_like 'gem rule', 'Middleman', 'middleman'
  end
end
