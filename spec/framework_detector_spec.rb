require 'spec_helper'

RSpec.describe Technologist::FrameworkDetector do
  describe '#frameworks' do
    it 'returns primary and secondary frameworks combined' do
      detector = Technologist::FrameworkDetector.new(nil)
      allow(detector).to receive(:matched_frameworks).and_return({
        'Framework1' => {},
        'Framework2' => {
          'primary' => 'Framework1'
        }
      })

      expect(detector.frameworks).to match_array ['Framework1', 'Framework2']
    end
  end
end
