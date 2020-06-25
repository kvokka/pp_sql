# PpSql

[![Version               ][rubygems_badge]][rubygems]
[![Build Status          ][travisci_badge]][travisci]
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

Ruby 2.4+

## Rails

Rails 4.2+ (optional), will be injected automatically

## Legacy

You can use version `~> 0.2` of this gem with Ruby 2.2, 2.3 and/or Rails 4.0, 4.1

## Usage

```
Post.first.to_sql
```

for easy and clean usage with custom string you can use build-in refinement:

```
  using PpSql::ToSqlBeautifyRefinement
```

Or if you need to use it wider

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
$ bundle
```

## With other formatters

If you are `pry` user, or use custom output formatter, use `puts` for output whitespaces,
like `puts User.all.to_sql`, or use `User.all.pp_sql`.

## With Rails

If you do not want to rewrite default `#to_sql` method you may specify
 `PpSql.rewrite_to_sql_method=false` in initializers. The `#pp_sql` method will still be
 available (for example, for use in the console).

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

## License
The gem is available as open source under the terms of the
[MIT License][mit-licence-link].

[rubygems_badge]: http://img.shields.io/gem/v/pp_sql.svg
[rubygems]: https://rubygems.org/gems/pp_sql
[travisci_badge]: https://travis-ci.org/kvokka/pp_sql.svg?branch=master
[travisci]: https://travis-ci.org/kvokka/pp_sql
[codacy_badge]: https://api.codacy.com/project/badge/Grade/7c866da60b1b4dd78eacc379cc0e7f3b
[codacy]: https://www.codacy.com/app/kvokka/pp_sql?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kvokka/pp_sql&amp;utm_campaign=Badge_Grade
[hound_badge]: https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg
[hound]: https://houndci.com

[anbt-sql-formatter-link]: https://github.com/sonota88/anbt-sql-formatter
[mit-licence-link]: http://opensource.org/licenses/MIT
[jetbrains-link]: https://www.jetbrains.com/?from=pp_sql
[jetbrains-img-link]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/jetbrains-variant-3.svg?sanitize=true

[log-img]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/log.png
[console-img]: https://raw.githubusercontent.com/kvokka/pp_sql/master/img/console.png