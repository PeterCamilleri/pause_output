#!/usr/bin/env rake
# coding: utf-8

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc "Run a scan for smelly code!"
task :reek do |t|
  `reek --no-color lib > reek.txt`
end

desc "What version of pause_output is this?"
task :vers do |t|
  puts
  puts "pause_output version = #{::PauseOutput::VERSION}"
end
