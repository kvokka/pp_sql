# frozen_string_literal: true

require 'test_helper'

describe PpSql do
  class SubString < String
    include PpSql::ToSqlBeautify
  end

  let(:str) { SubString.new 'SELECT COUNT(*) FROM "users"' }

  after { PpSql.rewrite_to_sql_method = true }

  it 'will format provided sql by default' do
    assert_equal str.to_sql.lines.count, 4
  end

  it 'will turn off rewriting to_sql' do
    PpSql.rewrite_to_sql_method = false
    assert_equal str.to_sql.lines.count, 1
  end

  it 'will continue to format with pp_sql' do
    PpSql.rewrite_to_sql_method = false
    assert_equal str.pp_sql.lines.count, 4
  end
end
