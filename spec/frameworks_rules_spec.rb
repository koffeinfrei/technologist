require 'spec_helper'

RSpec.describe 'Frameworks rules' do
  describe 'Rails' do
    it 'returns Rails when the rails gem rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'rails'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Rails when the jrails gem rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'jrails'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Rails when the boot.rb file rule matches (rails 2)' do
      repository = create_repository_with_file_content('boot.rb', "# All that for this:\nRails.boot!")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Locomotive' do
    it 'returns Rails as primary and Locomotive as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'locomotivecms_wagon'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Locomotive']
    end
  end

  describe 'Magnolia' do
    it 'returns Magnolia' do
      repository = create_repository_with_file_content('pom.xml', "bogus\n    <magnoliaVersion>    \nbogus")
      expect(repository.primary_frameworks).to eq ['Magnolia']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Sinatra' do
    it 'returns Sinatra when the config.ru file rule matches' do
      repository = create_repository_with_file_content('config.ru', "bogus\nrun Sinatra::Application\nbogus")
      expect(repository.primary_frameworks).to eq ['Sinatra']
    end

    it 'returns Sinatra when the gem file rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'sinatra'")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Dashing' do
    it 'returns Sinatra as primary and Dashing as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'dashing'")
      expect(repository.primary_frameworks).to eq ['Sinatra']
      expect(repository.secondary_frameworks).to eq ['Dashing']
    end
  end

  describe 'Middleman' do
    it 'returns Middleman' do
      repository = create_repository_with_file_content('Gemfile', "gem 'middleman'")
      expect(repository.primary_frameworks).to eq ['Middleman']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Meteor' do
    it 'returns Meteor' do
      repository = create_repository_with_directory('.meteor')
      expect(repository.primary_frameworks).to eq ['Meteor']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Locomotive' do
    it 'returns Rails as primary and Spree as secondary when the gem rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'spree'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Spree']
    end

    it 'returns Rails as primary and Spree as secondary boot.rb file rule matches' do
      repository = create_repository_with_file_content('boot.rb', "# All that for this:\nSpree.boot!")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Spree']
    end
  end

  describe 'Wordpress' do
    it 'returns Wordpress' do
      repository = create_repository_with_file('wp-settings.php')
      expect(repository.primary_frameworks).to eq ['Wordpress']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Volt' do
    it 'returns Volt' do
      repository = create_repository_with_file_content('Gemfile', "gem 'volt'")
      expect(repository.primary_frameworks).to eq ['Volt']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Ionic' do
    it 'returns Ionic' do
      repository = create_repository_with_file('ionic.project')
      expect(repository.primary_frameworks).to eq ['Ionic']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Node' do
    it 'returns Node' do
      repository = create_repository_with_file_content('package.json', %[
        "engines": {
          "other_engine": "1.0",
          "node": ">=0.10.22"
         }
      ])
      expect(repository.primary_frameworks).to eq ['Node']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Hoodie' do
    it 'returns Hoodie' do
      repository = create_repository_with_file_content('package.json', %[
        "hoodie": {
      ])
      expect(repository.primary_frameworks).to eq ['Node']
      expect(repository.secondary_frameworks).to eq ['Hoodie']
    end
  end

  describe 'PrestaShop' do
    it 'returns PrestaShop' do
      repository = create_repository_with_file_content('init.php', %{
        <?php
        /*
        * 2007-2015 PrestaShop
        *
      })
      expect(repository.primary_frameworks).to eq ['PrestaShop']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Cordova' do
    it 'returns Cordova' do
      repository = create_repository_with_file_content('config.xml', %{
        <?xml version='1.0' encoding='utf-8'?>
        <widget id="ch.panter.suitefox" version="0.1" xmlns="http://www.w3.org/ns/widgets" xmlns:cdv="http://cordova.apache.org/ns/1.0">
      })
      expect(repository.primary_frameworks).to eq ['Cordova']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'iOS' do
    it 'returns iOS' do
      repository = create_repository_with_file_content('project.pbxproj', %{
        ONLY_ACTIVE_ARCH = YES;
        SDKROOT = iphoneos;
        SWIFT_OPTIMIZATION_LEVEL = "-Onone";
      })
      expect(repository.primary_frameworks).to eq ['iOS']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Refinery CMS' do
    it 'returns Rails as primary and Refinery CMS as secondary' do
      repository = create_repository_with_file_content('Gemfile', "gem 'refinerycms'")
      expect(repository.primary_frameworks).to eq ['Rails']
      expect(repository.secondary_frameworks).to eq ['Refinery CMS']
    end
  end

  describe 'Rack' do
    it 'returns Rack when the gem rule matches' do
      repository = create_repository_with_file_content('Gemfile', "gem 'rack'")
      expect(repository.primary_frameworks).to eq ['Rack']
      expect(repository.secondary_frameworks).to eq []
    end

    it 'returns Rack when the config.ru file rule matches' do
      repository = create_repository_with_file_content('config.ru', %[
        ROOT = File.expand_path('..', __FILE__)

        run Proc.new { |env|
          path = ROOT + Rack::Utils.unescape(env['PATH_INFO'])
          # ...
        }
      ])
      expect(repository.primary_frameworks).to eq ['Rack']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Magento' do
    it 'returns Magento' do
      repository = create_repository_with_file_content('composer.json', %[
        {
          "repositories": {
            "installer-magento-core": {
              "type": "git",
              "url": "https://github.com/AydinHassan/magento-core-composer-installer"
            },
            "magento": {
                "type": "git",
                "url": "https://github.com/firegento/magento"
            },
            // ...
          }
        }
      ])
      expect(repository.primary_frameworks).to eq ['Magento']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Vaadin' do
    it 'returns Vaadin' do
      repository = create_repository_with_file_content('pom.xml', %[
        <dependency>
            <groupId>com.example.www</groupId>
            <artifactId>vaadin-application-components</artifactId>
            <version>${vaadin.base.version}</version>
        </dependency>
      ])
      expect(repository.primary_frameworks).to eq ['Vaadin']
      expect(repository.secondary_frameworks).to eq []
    end
  end

  describe 'Spring' do
    it 'returns Spring' do
      repository = create_repository_with_file_content('pom.xml', %[
        <dependency>
          <groupId>org.springframework</groupId>
          <artifactId>spring-web</artifactId>
          <version>${spring-version}</version>
        </dependency>
      ])
      expect(repository.primary_frameworks).to eq ['Spring']
      expect(repository.secondary_frameworks).to eq []
    end

    describe 'Felix' do
      it 'returns Felix' do
        repository = create_repository_with_file_content('pom.xml', %[
          <dependency>
            <groupId>org.apache.felix</groupId>
            <artifactId>org.osgi.core</artifactId>
            <version>1.2.0</version>
            <scope>provided</scope>
          </dependency>
        ])
        expect(repository.primary_frameworks).to eq ['Felix']
        expect(repository.secondary_frameworks).to eq []
      end
    end
  end
end
