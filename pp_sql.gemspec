# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'pp_sql/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pp_sql'
  s.version     = PpSql::VERSION
  s.authors     = ['Kvokka']
  s.email       = ['kvokka@yahoo.com']
  s.homepage    = 'https://github.com/kvokka/pp_sql'
  s.summary     = 'Beautify SQL output of ActiveRecord#to_sql'
  s.description = 'Helps to save your eyes, when reading hardcore SQL requests in console'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'activerecord'
  s.add_dependency 'anbt-sql-formatter', '~> 0.0.6', '~> 0.0.6'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-focus'
  s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'rails', '>= 4.2'
  s.add_development_dependency 'sqlite3', '< 1.4'
end
