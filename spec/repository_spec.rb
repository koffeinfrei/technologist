require 'spec_helper'

describe Technologist::Repository do
  describe '#frameworks' do
    it 'calls FrameworkDetector#frameworks' do
      repository = Technologist::Repository.new('.')

      expect(repository.framework_detector).to receive(:frameworks)

      repository.frameworks
    end
  end

  describe '#primary_frameworks' do
    it 'calls FrameworkDetector#primary_frameworks' do
      repository = Technologist::Repository.new('.')

      expect(repository.framework_detector).to receive(:primary_frameworks)

      repository.primary_frameworks
    end
  end

  describe '#secondary_frameworks' do
    it 'calls FrameworkDetector#secondary_frameworks' do
      repository = Technologist::Repository.new('.')

      expect(repository.framework_detector).to receive(:secondary_frameworks)

      repository.secondary_frameworks
    end
  end
end
