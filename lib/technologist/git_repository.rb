require 'rugged'

module Technologist
  class GitRepository
    attr_reader :repository

    def initialize(repository_path)
      @repository = Rugged::Repository.new(repository_path)
    end

    def tree
      repository.head.target.tree
    end

    def file_content(file_name)
      file = tree[file_name]

      if file
        repository.lookup(file[:oid]).content
      end
    end
  end
end
