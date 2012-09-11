#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test_*.rb']
  t.verbose = true
end

namespace :test do
  desc "Test everything"
  task :all => [:test]
end

task :default => :test

# Connect to Riak and test the client connection.

namespace :migrate do
  desc "Read in all decompressed objects, and save them to compressed encoding."
  task :compress do
    Ripple::Compression::Migrate.new.convert(:compress)
  end

  desc "Read in all compressed objects, and save them decompressed."
  task :decompress do
    Ripple::Compression::Migrate.new.convert(:decompress)
  end
end
