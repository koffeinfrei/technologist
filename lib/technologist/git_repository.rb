require 'rugged'

module Technologist
  class GitRepository
    attr_reader :repository

    def initialize(repository_path)
      @repository = Rugged::Repository.new(repository_path)
    end

    def root_tree
      repository.head.target.tree
    end

    # Returns the file content.
    #
    # @param file_name [String] the file name
    #
    # @return [String] The content of the file or nil if the file cannot be found.
    def file_content(file_name)
      file = find_file(file_name)

      file.content if file
    end

    # Recursively searches for the file identified by `file_name`
    # in all subdirectories in the repository.
    #
    # @param file_name [String] the file name
    # @param current_tree [Rugged::Tree] the git directory tree in which to look for the file.
    #   Defaults to the root tree (see `#root_tree`).
    #
    # @return [Rugged::Blob] The file blob or nil if it cannot be found.
    def find_file(file_name, current_tree = root_tree)
      file = current_tree[file_name]

      if file
        repository.lookup(file[:oid])
      else
        current_tree.each_tree do |sub_tree|
          file = find_file(file_name, repository.lookup(sub_tree[:oid]))
          break file if file
        end
      end
    end
  end
end
