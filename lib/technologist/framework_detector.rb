require 'yaml'

module Technologist
  class FrameworkDetector
    FRAMEWORK_RULES = File.expand_path('../frameworks.yml',  __FILE__)

    def initialize(repository)
      @repository = repository
    end

    def primary_frameworks
      matched_frameworks.map do |technology|
        # it's either the primary value defined in the yaml
        # or the technology itself
        rules[technology]['primary'] || technology
      end.uniq
    end

    def secondary_frameworks
      matched_frameworks.map do |technology|
        # it's a secondary if a primary is defined in the yaml
        rules[technology]['primary'] && technology
      end.compact
    end

    private

    attr_reader :repository

    def rules
      @rules ||= YAML.load_file(FRAMEWORK_RULES)
    end

    def matched_frameworks
      @frameworks ||=
        begin
          rules.map do |technology, definition|
            definition['rules'].map do |rule|
              if rule.matches?(technology, repository)
                technology
              end
            end
          end.flatten.compact
        end
    end
  end
end
