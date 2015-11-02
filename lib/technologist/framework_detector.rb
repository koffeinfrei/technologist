require 'technologist/yaml_parser'

module Technologist
  class FrameworkDetector
    FRAMEWORK_RULES = File.expand_path('../frameworks.yml',  __FILE__)

    attr_reader :repository, :yaml_parser

    def initialize(repository)
      @repository = repository
      @yaml_parser = YamlParser.new(FRAMEWORK_RULES)
    end

    def primary_frameworks
      matched_frameworks.map do |technology|
        # it's either the primary value defined in the yaml
        # or the technology itself
        yaml_parser.rules[technology]['primary'] || technology
      end.uniq
    end

    def secondary_frameworks
      matched_frameworks.map do |technology|
        # it's a secondary if a primary is defined in the yaml
        yaml_parser.rules[technology]['primary'] && technology
      end.compact
    end

    private

    def matched_frameworks
      @frameworks ||=
        begin
          yaml_parser.rules.map do |technology, definition|
            definition['rules'].map do |rule|
              if rule.matches?(repository)
                technology
              end
            end
          end.flatten.compact
        end
    end
  end
end
