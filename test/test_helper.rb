# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/focus'
require 'rails'
require 'pp_sql'

require 'minitest/reporters'
Minitest::Reporters.use!

ENV['RAILS_ENV'] = 'test'
ENV['DATABASE'] = 'sqlite3://localhost/:memory:'

module TeatApp
  class Application < Rails::Application
    config.eager_load = false
  end
end
