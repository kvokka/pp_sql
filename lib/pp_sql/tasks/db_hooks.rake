# frozen_string_literal: true

namespace :pp_sql do
  desc 'Hook that is ran before rails `db:*` tasks that can disable pp_sql'

  task :disable_during_db_tasks do
    PpSql.add_rails_logger_formatting = false
    PpSql.rewrite_to_sql_method = false
  end
end

db_tasks = Rake::Task.tasks.select { |task| task.name.starts_with?('db:') }
db_tasks.each { |task| task.enhance(['pp_sql:disable_during_db_tasks']) }
