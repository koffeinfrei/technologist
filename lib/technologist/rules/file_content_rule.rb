require 'technologist/rules/rule'

class FileContentRule < Rule
  attr_accessor :file_name, :file_content_pattern

  def matches?(framework_name, repository)
    !!repository.file_with_content_exists?(file_name) do |content|
      content =~ /#{file_content_pattern}/
    end
  end
end
