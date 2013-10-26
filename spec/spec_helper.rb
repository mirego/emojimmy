$:.unshift File.expand_path('../lib', __FILE__)

require 'coveralls'
Coveralls.wear!

require 'rspec'
require 'sqlite3'
require 'emojimmy'

# Require our macros and extensions
Dir[File.expand_path('../../spec/support/macros/**/*.rb', __FILE__)].map(&method(:require))

RSpec.configure do |config|
  # Include our macros
  config.include DatabaseMacros
  config.include ModelMacros

  config.before :suite do
    Emojimmy.initialize!
  end

  config.before :each do
    adapter = ENV['DB_ADAPTER'] || 'sqlite3'
    setup_database(adapter: adapter, database: 'emojimmy_test')
  end
end
