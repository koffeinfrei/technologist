require 'technologist/version'
require 'rugged'
require 'yaml'

module Technologist
  class Repository
    def initialize(repository_path)
      @repository = Rugged::Repository.new(repository_path)
    end

    def primary_frameworks
      matched_frameworks.map do |technology|
        # it's either the primary value defined in the yaml
        # or the technology itself
        framework_rules[technology]['primary'] || technology
      end.uniq
    end

    def secondary_frameworks
      matched_frameworks.map do |technology|
        # it's a secondary if a primary is defined in the yaml
        framework_rules[technology]['primary'] && technology
      end.compact
    end

    private

    attr_reader :repository

    def matched_frameworks
      @frameworks ||=
        begin
          framework_rules.map do |technology, definition|
            definition['rules'].map do |rule|
              rule = rule.flatten
              file_name = rule.first
              pattern = rule.last
              # may use single or double quotes
              pattern = pattern.gsub(/["']/, %q{["']})

              if file_content(file_name) =~ /#{pattern}/
                technology
              end
            end
          end.flatten.compact
        end
    end

    def tree
      repository.head.target.tree
    end

    def file_content(file_name)
      file = tree[file_name]

      if file
        repository.lookup(file[:oid]).content
      end
    end

    def framework_rules
      @framework_rules ||= YAML.load_file('lib/technologist/frameworks.yml')
    end
  end
end
