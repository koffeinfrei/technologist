require 'technologist/rules/rule'
require 'nokogiri'

class MavenPluginRule < Rule
  attr_accessor :file_name, :plugin_name, :css_selector

  def initialize(framework, attributes = {})
    super

    self.file_name = 'pom.xml'
  end

  def matches?(repository)
    self.css_selector = "dependencies dependency groupId[text() = '#{plugin_name}']"

    !!repository.file_with_content_exists?(file_name) do |content|
      xml = Nokogiri::XML(content)
      xml.css(css_selector).any?
    end
  end
end
