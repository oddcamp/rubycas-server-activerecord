require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "active_record"

RSpec::Core::RakeTask.new(:spec)

desc 'Run specs'
task :default => :spec

task :migrate do
  ActiveRecord::Base.establish_connection(
    adapter: "sqlite3",
    database: "db/development.sqlite3"
  )
  ActiveRecord::Migrator.migrate('db/migrate')
end


