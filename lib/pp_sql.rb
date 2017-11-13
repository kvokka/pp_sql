module PpSql
  # if you do not want to rewrite AR native method #to_sql
  # you may switch this setting to false in initializer
  mattr_accessor :rewrite_to_sql_method
  self.rewrite_to_sql_method = true
  module Formatter
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
  module ToSqlBeautify
    include Formatter
    def to_sql
      return super unless ::PpSql.rewrite_to_sql_method
      _sql_formatter.format(defined?(super) ? super.dup : self)
    end

    def pp_sql
      puts to_sql
    end
  end
  module Rails5PpSqlExtraction
    # export from Rails 5 with for Rails 4.2+ versions
    private

    def colorize_payload_name(name, payload_name)
      if payload_name.blank? || payload_name == "SQL" # SQL vs Model Load/Exists
        color(name, ActiveSupport::LogSubscriber::MAGENTA, true)
      else
        color(name, ActiveSupport::LogSubscriber::CYAN, true)
      end
    end

    def sql_color(sql)
      case sql
        when /\A\s*rollback/mi
          ActiveSupport::LogSubscriber::RED
        when /select .*for update/mi, /\A\s*lock/mi
          ActiveSupport::LogSubscriber::WHITE
        when /\A\s*select/i
          ActiveSupport::LogSubscriber::BLUE
        when /\A\s*insert/i
          ActiveSupport::LogSubscriber::GREEN
        when /\A\s*update/i
          ActiveSupport::LogSubscriber::YELLOW
        when /\A\s*delete/i
          ActiveSupport::LogSubscriber::RED
        when /transaction\s*\Z/i
          ActiveSupport::LogSubscriber::CYAN
        else
          ActiveSupport::LogSubscriber::MAGENTA
      end
    end
  end
  
  module LogSubscriberPrettyPrint
    include Formatter
    def sql(event)
      e=  event.dup
      e.payload[:sql] = _sql_formatter.format(e.payload[:sql].dup)
      super e
    end
  end

  class Railtie < Rails::Railtie
    initializer "pp_sql.override_to_sql" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Relation.send(:prepend, ToSqlBeautify)
        ActiveRecord::LogSubscriber.send(:prepend, LogSubscriberPrettyPrint)
        ActiveRecord::LogSubscriber.send(:include, Rails5PpSqlExtraction) if Rails::VERSION::MAJOR <= 4
      end
    end
  end
end
