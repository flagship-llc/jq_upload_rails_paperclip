ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment",  __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

require 'shoulda/matchers'
require 'paperclip/matchers'

require 'database_cleaner'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../')
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include Paperclip::Shoulda::Matchers
end
