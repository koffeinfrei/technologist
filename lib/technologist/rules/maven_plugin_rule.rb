require 'technologist/rules/file_xml_content_rule'

class MavenPluginRule < FileXmlContentRule
  attr_accessor :plugin_name

  def initialize(framework, attributes = {})
    super

    self.file_name = 'pom.xml'
    self.css_selector = "dependencies > dependency > groupId[text() = '#{plugin_name}']"
  end
end
