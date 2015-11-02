require 'technologist/rules/rule'

class FilePresenceRule < Rule
  attr_accessor :file_name

  def matches?(repository)
    repository.file_exists?(file_name)
  end
end
