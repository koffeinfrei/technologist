require 'spec_helper'

RSpec.describe Technologist::YamlParser do
  describe '#rules' do
    it 'maps the config to rule classes' do
      yaml_parser = Technologist::YamlParser.new(nil)
      allow(yaml_parser).to receive(:from_file) {
        YAML.load(%{
          Rails:
            rules:
              - Gem
              - Gem:
                gem_name: 'jrails'
              - FileContent:
                file_name: 'boot.rb'
                file_content_pattern: 'Rails.boot!'
            primary: Rack
        })
      }

      rules = yaml_parser.rules['Rails']

      expect(rules['rules'].count).to eq 3

      expect(rules['primary']).to eq 'Rack'

      expect(rules['rules'][0]).to be_an_instance_of GemRule
      expect(rules['rules'][0].gem_name).to be_nil

      expect(rules['rules'][1]).to be_an_instance_of GemRule
      expect(rules['rules'][1].gem_name).to eq 'jrails'

      expect(rules['rules'][2]).to be_an_instance_of FileContentRule
      expect(rules['rules'][2].file_name).to eq 'boot.rb'
      expect(rules['rules'][2].file_content_pattern).to eq 'Rails.boot!'
    end
  end
end
