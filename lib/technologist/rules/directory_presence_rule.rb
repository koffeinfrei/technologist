require 'technologist/rules/rule'

class DirectoryPresenceRule < Rule
  attr_accessor :directory_name

  def matches?(framework_name, repository)
    repository.directory_exists?(directory_name)
  end
end
