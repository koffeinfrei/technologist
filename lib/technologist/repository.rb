require 'technologist/framework_detector'
require 'technologist/git_repository'

module Technologist
  class Repository
    attr_reader :git_repository, :framework_detector

    def initialize(repository_path)
      @git_repository = GitRepository.new(repository_path)
      @framework_detector = FrameworkDetector.new(@git_repository)
    end

    def frameworks
      framework_detector.frameworks
    end

    def primary_frameworks
      framework_detector.primary_frameworks
    end

    def secondary_frameworks
      framework_detector.secondary_frameworks
    end
  end
end
