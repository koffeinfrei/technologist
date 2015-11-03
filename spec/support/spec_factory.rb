module SpecFactory
  def create_repository_with_file_content(file_name, file_content)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:find_blob)

      # stub for a git blob (i.e. the file in git)
      blob = double(:blob)
      allow(blob).to receive(:content).and_return(file_content)

      # yield the blob
      allow(repository.git_repository).to receive(:find_blob).with(file_name).and_yield(blob)
    end
  end

  def create_repository_with_file(file_name)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:file_exists?).and_return(false)

      allow(repository.git_repository).to receive(:file_exists?).with(file_name).and_return(true)
    end
  end

  def create_repository_with_directory(directory_name)
    Technologist::Repository.new('.').tap do |repository|
      allow(repository.git_repository).to receive(:directory_exists?).with(directory_name).and_return(true)
    end
  end
end
