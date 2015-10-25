require 'technologist/version'
require 'technologist/repository'
Dir[File.expand_path('../technologist/rules/*.rb', __FILE__)].each { |file| require file }

module Technologist
end
