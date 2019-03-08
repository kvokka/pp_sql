# frozen_string_literal: true

require 'rails'
require 'test_helper'
require 'active_record'
require 'sqlite3'
ENV['RAILS_ENV'] = 'test'

module TeatApp
  class Application < Rails::Application
    config.eager_load = false
    initialize!
  end
end

module ActiveRecord
  class Base
    establish_connection(adapter: 'sqlite3', database: ':memory:')
    connection.create_table(:users) { |t| t.string :name }
    self.logger = Logger.new(::LOGGER = StringIO.new)
  end
end

class User < ActiveRecord::Base; end

describe PpSql do
  after { clear_logs! && set_default_config! }

  it 'load with formatted output' do
    User.create
    assert(LOGGER.string.lines.detect { |line| line =~ /INTO\n/ })
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 6
  end

  it 'load with default output' do
    PpSql.add_rails_logger_formatting = false
    User.create
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 1
  end

  private

  def clear_logs!
    LOGGER.string.clear
  end

  def set_default_config!
    PpSql.add_rails_logger_formatting = true
  end
end
