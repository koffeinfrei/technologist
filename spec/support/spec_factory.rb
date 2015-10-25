module SpecFactory
  def create_repository_with_file_content(file_name, file_content)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:file_content).and_return(nil)

      allow(repository.git_repository).to receive(:file_content).with(file_name).and_return(file_content)
    end
  end

  def create_repository_with_file(file_name)
    Technologist::Repository.new('.').tap do |repository|
      allow(repository.git_repository).to receive(:file_exists?).with(file_name).and_return(true)
    end
  end

  def create_repository_with_directory(directory_name)
    Technologist::Repository.new('.').tap do |repository|
      allow(repository.git_repository).to receive(:directory_exists?).with(directory_name).and_return(true)
    end
  end
end
