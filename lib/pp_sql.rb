module PpSql
  module ToSqlBeautify
    def to_sql
      _sql_formatter.format(super)
    end

    private

    def _sql_formatter
      return @_sql_formatter if @_sql_formatter
      require "anbt-sql-formatter/formatter"
      rule = AnbtSql::Rule.new
      rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE
      %w(count sum substr date).each { |func_name| rule.function_names << func_name.upcase }
      rule.indent_string = "  "
      @_sql_formatter = AnbtSql::Formatter.new(rule)
    end
  end
  class Railtie < Rails::Railtie
    initializer "pp_sql.override_to_sql" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Relation.send(:prepend, ToSqlBeautify)
      end
    end
  end
end
