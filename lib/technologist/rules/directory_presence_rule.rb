require 'technologist/rules/rule'

class DirectoryPresenceRule < Rule
  attr_accessor :directory_name

  def matches?(repository)
    repository.directory_exists?(directory_name)
  end
end
