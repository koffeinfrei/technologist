require 'technologist/rules/file_content_rule'

class GemRule < FileContentRule
  attr_accessor :gem_name

  def matches?(framework_name, repository)
    self.file_name = 'Gemfile'
    self.gem_name ||= framework_name.downcase
    self.file_content_pattern = /^\s*gem ["']#{gem_name}["']/

    super
  end
end
