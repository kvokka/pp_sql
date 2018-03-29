# frozen_string_literal: true

require 'test_helper'

TeatApp::Application.initialize!

require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Base.connection.create_table(:users) do |t|
  t.string :name
end

ActiveRecord::Base.logger = Logger.new(LOGGER = StringIO.new)

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
