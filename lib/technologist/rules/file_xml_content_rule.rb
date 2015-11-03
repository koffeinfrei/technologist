require 'technologist/rules/rule'
require 'nokogiri'

class FileXmlContentRule < Rule
  attr_accessor :file_name, :css_selector

  def matches?(repository)
    !!repository.file_with_content_exists?(file_name) do |content|
      xml = Nokogiri::XML(content)
      xml.css(css_selector).any?
    end
  end
end
