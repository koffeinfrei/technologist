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
      matched_frameworks.map do |technology, definition|
        # it's either the primary value defined in the yaml
        # or the technology itself
        definition['primary'] || technology
      end.uniq
    end

    def secondary_frameworks
      matched_frameworks.map do |technology, definition|
        # it's a secondary if a primary is defined in the yaml
        definition['primary'] && technology
      end.compact
    end

    private

    def matched_frameworks
      @frameworks ||=
        begin
          matched_rules = yaml_parser.rules.select do |technology, definition|
            definition['rules'].any? do |rule|
              rule.matches?(repository)
            end
          end
          Hash[matched_rules]
        end
    end
  end
end
