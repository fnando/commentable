require "bundler"
Bundler.setup(:default, :development)
Bundler.require

require "commentable"
require "test_notifier/runner/rspec"
require "redcarpet"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
load File.dirname(__FILE__) + "/schema.rb"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each do |file|
  require file
end
