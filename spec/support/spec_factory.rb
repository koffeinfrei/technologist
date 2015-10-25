module SpecFactory
  def create_repository(file_name, file_content)
    Technologist::Repository.new('.').tap do |repository|
      # default file content for non existing files
      allow(repository.git_repository).to receive(:file_content).and_return(nil)

      allow(repository.git_repository).to receive(:file_content).with(file_name).and_return(file_content)
    end
  end
end
