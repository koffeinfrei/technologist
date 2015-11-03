require 'spec_helper'

RSpec.describe FileXmlContentRule do
  describe '#matches?' do
    it 'returns true when the xml matches the css selector' do
      rule = FileXmlContentRule.new(
        'Framework1',
        file_name: 'example.xml',
        css_selector: 'dependencyManagement > dependencies > dependency > groupId[text() = "com.example.www"]'
      )

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('example.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <groupId>com.example.www</groupId>
              </dependency>
            </dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq true
    end

    it 'returns false when the xml is commented out' do
      rule = FileXmlContentRule.new(
        'Framework1',
        file_name: 'example.xml',
        css_selector: 'dependencyManagement > dependencies > dependency > groupId[text() = "com.example.www"]'
      )

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('example.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <!-- <groupId>com.example.www</groupId> -->
              </dependency>
            </dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq false
    end

    it 'returns false when the xml does not match the css selector' do
      rule = FileXmlContentRule.new(
        'Framework1',
        file_name: 'example.xml',
        css_selector: 'dependencyManagement > dependency > groupId[text() = "com.example.www"]'
      )

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('example.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <groupId>com.example.www</groupId>
              </dependency>
            </dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq false
    end
  end
end

