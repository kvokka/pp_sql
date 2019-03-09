# frozen_string_literal: false

require 'test_helper'

using PpSql::ToSqlBeautifyRefinement

module PpSql
  describe ToSqlBeautifyRefinement do
    let(:str) { 'SELECT COUNT(*) FROM "users"' }

    it 'will parse provided sql' do
      assert_equal str.to_sql.lines.count, 4
    end
  end
end
