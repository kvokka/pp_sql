# frozen_string_literal: true

module PpSql
  # if you do not want to rewrite AR native method #to_sql
  # you may switch this setting to false in initializer
  class << self
    attr_accessor :rewrite_to_sql_method
    attr_accessor :add_rails_logger_formatting
  end
  self.rewrite_to_sql_method = true
  self.add_rails_logger_formatting = true

  module Formatter
    private

    def _sql_formatter
      return @_sql_formatter if defined?(@_sql_formatter) && @_sql_formatter

      require 'anbt-sql-formatter/formatter'
      rule = AnbtSql::Rule.new
      rule.keyword = AnbtSql::Rule::KEYWORD_UPPER_CASE
      %w[count sum substr date].each { |func_name| rule.function_names << func_name.upcase }
      rule.indent_string = '  '
      @_sql_formatter = AnbtSql::Formatter.new(rule)
    end
  end

  module ToSqlBeautify
    def to_sql
      if ::PpSql.rewrite_to_sql_method
        extend Formatter
        _sql_formatter.format(defined?(super) ? super.dup : dup)
      else
        defined?(super) ? super : self
      end
    end

    def pp_sql
      if ::PpSql.rewrite_to_sql_method
        puts to_sql
      else
        extend Formatter
        puts _sql_formatter.format(to_sql.to_s)
      end
    end
  end

  module ToSqlBeautifyRefinement
    refine String do
      include PpSql::ToSqlBeautify
    end
  end

  module LogSubscriberPrettyPrint
    include Formatter

    def sql(event)
      return super event unless ::PpSql.add_rails_logger_formatting

      e = event.dup
      e.payload[:sql] = _sql_formatter.format(e.payload[:sql].dup)
      super e
    end
  end

  if defined?(::Rails::Railtie)
    class Railtie < Rails::Railtie
      initializer 'pp_sql.override_to_sql' do
        ActiveSupport.on_load(:active_record) do
          ActiveRecord::Relation.send(:prepend, ToSqlBeautify)
          ActiveRecord::LogSubscriber.send(:prepend, LogSubscriberPrettyPrint)
        end
      end
    end
  end
end
