# frozen_string_literal: true

require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << %w[test lib]
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task default: :test
