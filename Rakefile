require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rdoc/task' # 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "fred"
    gem.summary = %Q{Ruby wrapper for the St. Louis Federal Reserve FRED API}
    gem.description = %Q{Ruby wrapper for the St. Louis Federal Reserve FRED API}
    gem.email = "ryan.b.harvey@gmail.com"
    gem.homepage = "http://github.com/nihonjinrxs/fred"
    gem.authors = ["Johnny Khai Nguyen","Ryan B. Harvey"]
    # Dependencies
    gem.add_dependency 'httparty', '>= 0.5.0'
    gem.add_dependency 'hashie'
    # Dependencies (Development)
    gem.add_development_dependency 'rspec'
    gem.add_development_dependency 'fakeweb'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

desc 'Default: run unit tests.'
#task :default => :test
task :default => :spec

begin
  require "rspec/core/rake_task"

  desc "Test the fred plugin"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w[--color]
    t.pattern = 'spec/*_spec.rb'
  end
rescue LoadError
end

#desc 'Test the fred plugin.'
#Rake::TestTask.new(:test) do |t|
#  t.libs << 'lib'
#  t.libs << 'test'
#  t.pattern = 'test/**/*_test.rb'
#  t.verbose = true
#end

desc 'Generate documentation for the fred plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Fred'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

