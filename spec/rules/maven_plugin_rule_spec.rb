require 'spec_helper'

RSpec.describe MavenPluginRule do
  describe '#matches?' do
    it 'returns true when the file contains the plugin name' do
      rule = MavenPluginRule.new('Framework1', plugin_name: 'com.example.next-generation-plugin')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('pom.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <groupId>com.example.www</groupId>
                <artifactId>whatever</artifactId>
                <version>3.7</version>
              </dependency>
              <dependency>
                <groupId>com.example.next-generation-plugin</groupId>
                <artifactId>something</artifactId>
                <version>${nextGenerationPluginVersion}</version>
                <scope>runtime</scope>
              </dependency>
            <dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq true
    end

    it 'returns false when the plugin is commented out' do
      rule = MavenPluginRule.new('Framework1', plugin_name: 'com.example.next-generation-plugin')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('pom.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <groupId>com.example.www</groupId>
                <artifactId>whatever</artifactId>
                <version>3.7</version>
              </dependency>
              <!-- <dependency> -->
              <!--   <groupId>com.example.next-generation-plugin</groupId> -->
              <!--   <artifactId>something</artifactId> -->
              <!--   <version>${nextGenerationPluginVersion}</version> -->
              <!--   <scope>runtime</scope> -->
              <!-- </dependency> -->
            <dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq false
    end
    it 'returns false when the file does not contain the plugin' do
      rule = MavenPluginRule.new('Framework1', plugin_name: 'com.example.next-generation-plugin')

      repository = double(:repository)
      allow(repository).to receive(:file_with_content_exists?).with('pom.xml')
        .and_yield(%{
          <dependencyManagement>
            <dependencies>
              <dependency>
                <groupId>com.example.www</groupId>
                <artifactId>whatever</artifactId>
                <version>3.7</version>
              </dependency>
            <dependencies>
          </dependencyManagement>
        })

      expect(rule.matches?(repository)).to eq false
    end
  end
end
