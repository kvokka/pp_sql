# frozen_string_literal: true

require 'test_helper'

describe PpSql do
  class SubString < String
    include PpSql::ToSqlBeautify
  end

  let(:str) { SubString.new 'SELECT COUNT(*) FROM "users"' }

  after { PpSql.rewrite_to_sql_method = true }

  it 'will parse provided sql' do
    assert_equal str.to_sql.lines.count, 4
  end

  it 'throw string as is' do
    PpSql.rewrite_to_sql_method = false
    assert_equal str.to_sql.lines.count, 1
  end
end
