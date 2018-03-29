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

class ActiveRecord::Base
  establish_connection(adapter: 'sqlite3', database: ':memory:')
  connection.create_table(:users) { |t| t.string :name }
  self.logger = Logger.new(::LOGGER = StringIO.new)
end

class User < ActiveRecord::Base; end

describe PpSql do
  after { clear_logs! }

  it 'load with right output' do
    User.create
    assert(LOGGER.string.lines.detect { |line| line =~ /INTO\n/ })
    clear_logs!
    User.first
    assert_equal LOGGER.string.lines.count, 6
  end

  private

  def clear_logs!
    LOGGER.string.clear
  end
end
