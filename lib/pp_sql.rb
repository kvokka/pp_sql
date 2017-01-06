module PpSql
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
      _sql_formatter.format(super)
    end

    def pp_sql
      puts to_sql
    end
  end
  module LogSubscriberPrettyPrint
    include Formatter
    def sql(event)
      return unless logger.debug?

      self.class.runtime += event.duration

      payload = event.payload

      return if ActiveRecord::LogSubscriber::IGNORE_PAYLOAD_NAMES.include?(payload[:name])

      name  = "#{payload[:name]} (#{event.duration.round(1)}ms)"
      sql   = payload[:sql]
      binds = nil

      unless (payload[:binds] || []).empty?
        binds = "  " + payload[:binds].map { |attr| render_bind(attr) }.inspect
      end

      name = colorize_payload_name(name, payload[:name])
      # only this line was rewritten from the AR
      sql  = color(_sql_formatter.format(sql.dup), sql_color(sql), true)

      debug "  #{name}  #{sql}#{binds}"
    end
  end
  class Railtie < Rails::Railtie
    initializer "pp_sql.override_to_sql" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Relation.send(:prepend, ToSqlBeautify)
        ActiveRecord::LogSubscriber.send(:prepend, LogSubscriberPrettyPrint)
      end
    end
  end
end
