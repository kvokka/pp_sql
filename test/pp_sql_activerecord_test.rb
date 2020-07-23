# frozen_string_literal: true

require 'test_helper'
require 'sqlite3'
require 'active_record'

module ActiveRecord
  class Base
    establish_connection(adapter: 'sqlite3', database: ':memory:')
    connection.create_table(:users) { |t| t.string :name }
    self.logger = Logger.new(::LOGGER = StringIO.new)
  end

  class Relation
    prepend PpSql::ToSqlBeautify
  end

  class LogSubscriber
    prepend PpSql::LogSubscriberPrettyPrint
  end
end

class User < ActiveRecord::Base; end

describe PpSql do
  after { clear_logs! && set_default_config! }

  it 'ActiveRecord with formatted output' do
    User.create
    assert(LOGGER.string.lines.detect { |line| line =~ /INTO\n/ })
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 6
  end

  it 'ActiveRecord with default output' do
    PpSql.add_rails_logger_formatting = false
    User.create
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 1
  end

  it 'to_sql formats a relation properly' do
    User.create
    assert_equal User.all.to_sql, "SELECT\n    \"users\" . *\n  FROM\n    \"users\""
  end

  it 'pp_sql formats a relation properly' do
    User.create
    out, = capture_io do
      User.all.pp_sql
    end
    assert_equal out, "SELECT\n    \"users\" . *\n  FROM\n    \"users\"\n"
  end

  private

  def clear_logs!
    LOGGER.string.clear
  end

  def set_default_config!
    PpSql.add_rails_logger_formatting = true
  end
end
