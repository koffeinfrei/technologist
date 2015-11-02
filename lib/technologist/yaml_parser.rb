require 'yaml'

module Technologist
  class YamlParser
    attr_reader :file_name

    def initialize(file_name)
      @file_name = file_name
    end

    def rules
      @rules ||=
        begin
          parsed_rules = from_file.map do |technology, definition|
            # Create a class instance for each rule entry
            definition['rules'].map! do |rule|
              class_name, attributes = send("parse_rule_of_type_#{rule.class.name.downcase}", rule)

              Rule.const_get("#{class_name}Rule").new(technology, attributes)
            end

            [technology, definition]
          end

          Hash[parsed_rules]
        end
    end

    private

    def from_file
      YAML.load_file(file_name)
    end

    # Parses a yaml rule where the rule entry is a string,
    # meaning that only the rule class name is given.
    # Sample yaml structure:
    #   ```
    #     Rails:
    #       rules:
    #         - Gem
    #   ```
    def parse_rule_of_type_hash(rule)
      class_name = rule.keys.first
      rule.delete(class_name)
      attributes = rule

      [class_name, attributes]
    end

    # Parses a yaml rule where the rule entry is a hash,
    # meaning that the rule class also has attributes to be assigned.
    # Sample yaml structure:
    #   ```
    #     Rails:
    #       rules:
    #         - Gem:
    #           gem_name: 'jrails'
    #   ```
    def parse_rule_of_type_string(rule)
      class_name = rule
      attributes = {}

      [class_name, attributes]
    end
  end
end
