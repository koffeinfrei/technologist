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
      file = find_blob(file_name)

      file.content if file
    end

    # Recursively searches for the blob identified by `blob_name`
    # in all subdirectories in the repository. A blob is usually either
    # a file or a directory.
    #
    # @param blob_name [String] the blob name
    # @param current_tree [Rugged::Tree] the git directory tree in which to look for the blob.
    #   Defaults to the root tree (see `#root_tree`).
    #
    # @return [Rugged::Blob] The blob blob or nil if it cannot be found.
    def find_blob(blob_name, current_tree = root_tree)
      blob = current_tree[blob_name]

      if blob
        repository.lookup(blob[:oid])
      else
        current_tree.each_tree do |sub_tree|
          blob = find_blob(blob_name, repository.lookup(sub_tree[:oid]))
          break blob if blob
        end
      end
    end

    # Looks for a directory and returns true when the directory
    # can be found.
    #
    # @param directory_name [String] the directory name
    #
    # @return [Boolean] true if the directory can be found.
    def directory_exists?(directory_name)
      !!find_blob(directory_name)
    end
  end
end
