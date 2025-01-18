# frozen_string_literal: true

require 'test_helper'
require 'sqlite3'
require 'active_record'

module ActiveRecord
  class Base
    establish_connection(adapter: 'sqlite3', database: ':memory:')
    connection.create_table(:users) { |t| t.string :name }
    self.logger = Logger.new(::LOGGER)
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

  it 'ActiveRecord logs with formatted output' do
    User.create
    assert(LOGGER.string.lines.detect { |line| line =~ /INTO\n/ })
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 6
  end

  it 'ActiveRecord logs with default output' do
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

  it 'to_sql with default output' do
    PpSql.rewrite_to_sql_method = false
    User.create
    assert_equal User.all.to_sql.lines.count, 1
  end

  it 'to_sql with default output but formatted logs' do
    PpSql.rewrite_to_sql_method = false
    User.create
    assert_equal User.all.to_sql.lines.count, 1
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 6
  end

  it 'pp_sql formats a relation properly' do
    User.create
    out, = capture_io do
      User.all.pp_sql
    end
    assert_equal out, "SELECT\n    \"users\" . *\n  FROM\n    \"users\"\n"
  end

  it 'pp_sql formats frozen strings properly' do
    PpSql.rewrite_to_sql_method = false
    User.create
    frozen_clause = 'id > 0'
    out, = capture_io do
      User.all.where(frozen_clause).pp_sql
    end
    assert_equal out.lines.count, 8
  end

  private

  def clear_logs!
    LOGGER.string.clear
  end

  def set_default_config!
    PpSql.rewrite_to_sql_method = true
    PpSql.add_rails_logger_formatting = true
  end
end
