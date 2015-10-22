RSpec.shared_examples "gem rule" do |framework, gem_name|
  it "returns #{framework} as primary when specified with version" do
    repository = create_repository('Gemfile', "bogus\ngem '#{gem_name}', '~> 4.3'\nbogus")
    expect(repository.primary_frameworks).to eq [framework]
  end

  it "returns #{framework} as primary when indented" do
    repository = create_repository('Gemfile', "bogus\n  gem '#{gem_name}'\nbogus")
    expect(repository.primary_frameworks).to eq [framework]
  end

  it "does not return #{framework} as primary when commented out" do
    repository = create_repository('Gemfile', "bogus\n# gem '#{gem_name}'\nbogus")
    expect(repository.primary_frameworks).to eq []
  end
end
