# frozen_string_literal: true

# rubocop:disable Security/Eval
skip_gems_snippet = <<~GEMS
  group :local_development do
    %w[appraisal overcommit pry reek rubocop rails sqlite3].each { |gem_name| remove_gem gem_name }
  end
GEMS

appraise 'rails-7-0' do
  gem 'rails', '~> 7.0.0'
  gem 'sqlite3', '~> 1.6'
  eval(skip_gems_snippet)
end

appraise 'rails-7-1' do
  gem 'rails', '~> 7.1.0'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end

appraise 'rails-7-2' do
  gem 'rails', '~> 7.2.0'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end

appraise 'rails-8-0' do
  gem 'rails', '~> 8.0.0'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end

appraise 'activerecord-7-0' do
  gem 'activerecord', '~> 7.0.0'
  gem 'rake'
  gem 'sqlite3', '~> 1.6'
  eval(skip_gems_snippet)
end

appraise 'activerecord-7-1' do
  gem 'activerecord', '~> 7.1.0'
  gem 'rake'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end

appraise 'activerecord-7-2' do
  gem 'activerecord', '~> 7.2.0'
  gem 'rake'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end

appraise 'activerecord-8-0' do
  gem 'activerecord', '~> 8.0.0'
  gem 'rake'
  gem 'sqlite3', '~> 2.0'
  eval(skip_gems_snippet)
end
# rubocop:enable Security/Eval
