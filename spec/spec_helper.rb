$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'technologist'
require 'support/spec_factory'

RSpec.configure do |config|
  config.include SpecFactory
end
