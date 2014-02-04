require "bundler/gem_tasks"
require "rspec/core/tasks"
require "active_record"

RSpec::Core::RakeTask.new(:spec)

task :default => :run_specs

desc "Migrate the database through scripts in db/migrate."
task :migrate do
  ActiveRecord::Migrator.migrate('db/migrate')
end

desc "Run the tests"
task :run_specs => :spec => :migrate
