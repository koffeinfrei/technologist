$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'technologist'
require 'support/spec_factory'

RSpec.configure do |config|
  config.include SpecFactory

  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end
