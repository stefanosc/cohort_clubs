 require 'rake'
require 'rspec/core/rake_task'

require_relative 'config/application'

namespace :generate do
  desc "Generate a blank migration"
  task :migration, [:m_name] do |t, args|
    timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    file_name = [timestamp, args[:m_name]].join('_') + '.rb'
    path = APP_ROOT.join('db','migrate')
    class_name = ActiveSupport::Inflector.camelize(args[:m_name])
    unless File.exist?(File.join(path, file_name))
      File.open(File.join(path, file_name), 'w+') do |f|
        f.write(<<-RUBY
class #{class_name} < ActiveRecord::Migration
  def change
  end
end
RUBY
          )
      end
    end
  end
end

desc "create the database"
task "db:create" do
  puts "Creating file #{DB_PATH} if it doesn't exist..."
  touch DB_PATH
end

desc "drop the database"
task "db:drop" do
  puts "Deleting #{DB_PATH}..."
  rm_f DB_PATH
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc "rollback your migration--use STEPS=number to step back multiple times"
task "db:rollback" do
  steps = (ENV['STEPS'] || 1).to_i
  ActiveRecord::Migrator.rollback('db/migrate', steps)
  Rake::Task['db:version'].invoke if Rake::Task['db:version']
end

desc "populate the test database with sample data"
task "db:seed" do
  require APP_ROOT.join('db', 'seeds.rb')
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "pry -r./config/application"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:spec)

task :default  => :specs
