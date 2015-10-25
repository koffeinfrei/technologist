require 'yaml'

module Technologist
  class FrameworkDetector
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
      @rules ||=
        begin
          rules = YAML.load_file('lib/technologist/frameworks.yml')
          # skip the template rules
          rules.delete('template_rules')
          rules
        end
    end

    def matched_frameworks
      @frameworks ||=
        begin
          rules.map do |technology, definition|
            definition['rules'].map do |rule|
              rule = rule.flatten
              file_name = rule.first
              pattern = rule.last
              # may use single or double quotes
              pattern = pattern.gsub(/["']/, %q{["']})
              # may contain a placeholder for template rules
              pattern = format(pattern, name: technology.downcase)

              if repository.file_content(file_name) =~ /#{pattern}/
                technology
              end
            end
          end.flatten.compact
        end
    end
  end
end
