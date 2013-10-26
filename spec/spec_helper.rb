$:.unshift File.expand_path('../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'rspec'
require 'emojimmy'

RSpec.configure do |config|
  config.before :suite do
    Emojimmy.initialize!
  end
end
