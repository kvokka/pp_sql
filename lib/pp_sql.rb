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

  module Rails5PpSqlExtraction
    # export from Rails 5 with for Rails 4.2+ versions

    private

    def colorize_payload_name(name, payload_name)
      if payload_name.blank? || payload_name == 'SQL' # SQL vs Model Load/Exists
        color(name, ActiveSupport::LogSubscriber::MAGENTA, true)
      else
        color(name, ActiveSupport::LogSubscriber::CYAN, true)
      end
    end

    def sql_color(sql)
      case sql
      when /\A\s*rollback/mi                      then ActiveSupport::LogSubscriber::RED
      when /select .*for update/mi, /\A\s*lock/mi then ActiveSupport::LogSubscriber::WHITE
      when /\A\s*select/i                         then ActiveSupport::LogSubscriber::BLUE
      when /\A\s*insert/i                         then ActiveSupport::LogSubscriber::GREEN
      when /\A\s*update/i                         then ActiveSupport::LogSubscriber::YELLOW
      when /\A\s*delete/i                         then ActiveSupport::LogSubscriber::RED
      when /transaction\s*\Z/i                    then ActiveSupport::LogSubscriber::CYAN
      else                                             ActiveSupport::LogSubscriber::MAGENTA
      end
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
          ActiveRecord::LogSubscriber.send(:include, Rails5PpSqlExtraction) if Rails::VERSION::MAJOR <= 4
        end
      end
    end
  end
end
