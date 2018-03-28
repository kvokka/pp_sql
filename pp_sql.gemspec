$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'pp_sql/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'pp_sql'
  s.version     = PpSql::VERSION
  s.authors     = ['Kvokka']
  s.email       = ['root_p@mail.ru']
  s.homepage    = 'https://github.com/kvokka/pp_sql'
  s.summary     = 'Beautify SQL output of ActiveRecord#to_sql'
  s.description = 'Helps to save your eyes, when reading hardcore SQL requests in console'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'anbt-sql-formatter', '~> 0.0.5', '~> 0.0.5'
  s.add_dependency 'rails', '>= 4.0.0', '>= 4.0.0'

  s.add_development_dependency 'minitest',       '~> 5.6'
  s.add_development_dependency 'minitest-focus', '~> 1.1'
  s.add_development_dependency 'overcommit',     '~> 0.44.0'
  s.add_development_dependency 'reek',           '~> 4.0'
  s.add_development_dependency 'rubocop',        '~> 0.54.0'
end
