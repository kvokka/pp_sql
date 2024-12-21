# PpSql

[![Version               ][rubygems_badge]][rubygems]
[![Codacy Badge          ][codacy_badge]][codacy]
[![Reviewed by Hound     ][hound_badge]][hound]

Replace standard `ActiveRecord#to_sql` method with
[`anbt-sql-formatter`][anbt-sql-formatter-link]
gem for pretty SQL code output in console. Rails log will be formatted also.
Example output:

![log][log-img]

Or in console

![console][console-img]

## Require

Ruby 3.1+

## Rails

Rails 7.0+ (optional), will be injected automatically

## Legacy

You can use version `~> 0.2` of this gem with Ruby 2.2, 2.3 and/or Rails 4.0, 4.1

## Usage

```
Post.first.to_sql
```

for easy and clean usage with custom string you can use:

```
class MyAwesomeDecoratedString < String
  include PpSql::ToSqlBeautify
end
```

## Installation

add in Gemfile

```
gem 'pp_sql', group: :development
```

And then execute:

```bash
bundle
```

## With other formatters

If you are `pry` user, or use custom output formatter, use `puts` for output whitespaces,
like `puts User.all.to_sql`, or use `User.all.pp_sql`.

## With Rails

If you do not want to rewrite default `#to_sql` method you may specify
 `PpSql.rewrite_to_sql_method=false` in initializers.

You can also disable log formatting by specifying `PpSql.add_rails_logger_formatting=false`
in initializers.

### Add to Application record

I found usefull this trick:

 ```
 class ApplicationRecord < ActiveRecord::Base
  include PpSql::ToSqlBeautify if defined?(Rails::Console)

  self.abstract_class = true
end
```

### Supported by

[![jetbrains][jetbrains-img-link]][jetbrains-link]

## Contributing

Running the tests requires sqlite. To run the tests for different combinations of dependency
versions, run `bundle exec appraisal install` followed by `bundle exec appraisal rake`.

## License

The gem is available as open source under the terms of the
[MIT License][mit-licence-link].

[rubygems_badge]: http://img.shields.io/gem/v/pp_sql.svg
[rubygems]: https://rubygems.org/gems/pp_sql
[codacy_badge]: https://app.codacy.com/project/badge/Grade/0394889311ea49529ddea12baac9b699
[codacy]: https://www.codacy.com/gh/kvokka/pp_sql/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kvokka/pp_sql&amp;utm_campaign=Badge_Grade
[hound_badge]: https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg
[hound]: https://houndci.com

[anbt-sql-formatter-link]: https://github.com/sonota88/anbt-sql-formatter
[mit-licence-link]: http://opensource.org/licenses/MIT
[jetbrains-link]: https://www.jetbrains.com/?from=pp_sql
[jetbrains-img-link]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/jetbrains-variant-3.svg?sanitize=true

[log-img]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/log.png
[console-img]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/console.png
