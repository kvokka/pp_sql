# frozen_string_literal: true

source 'https://rubygems.org'

# Declare your gem's dependencies in pp_sql.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use a debugger
# gem 'byebug', group: [:development, :test]
#

# https://stackoverflow.com/questions/79360526/uninitialized-constant-activesupportloggerthreadsafelevellogger-nameerror
gem 'concurrent-ruby', '1.3.4'
gem 'minitest'
gem 'minitest-focus'
gem 'minitest-reporters'

group :local_development do
  gem 'appraisal'
  gem 'overcommit'
  gem 'pry'
  gem 'rails', '>= 7.0'
  gem 'reek'
  gem 'rubocop', '~> 1.69.0'
  gem 'sqlite3', '>= 1.4'
end
