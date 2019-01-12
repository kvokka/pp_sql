# PpSql 
[![Build Status](https://travis-ci.org/kvokka/pp_sql.svg?branch=master)](https://travis-ci.org/kvokka/pp_sql) 
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/7c866da60b1b4dd78eacc379cc0e7f3b)](https://www.codacy.com/app/kvokka/pp_sql?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=kvokka/pp_sql&amp;utm_campaign=Badge_Grade)

Replace standard `ActiveRecord#to_sql` method with 
[`anbt-sql-formatter`](https://github.com/sonota88/anbt-sql-formatter)
gem for pretty SQL code output in console. Rails log will be formatted also. 
Example output:

![log](https://raw.githubusercontent.com/kvokka/pp_sql/master/screenshots/log.png)

Or in console

![console](https://raw.githubusercontent.com/kvokka/pp_sql/master/screenshots/console.png)

## Require

Ruby 2.2+

## Rails

Rails 4.0+ (optional), will be injected automatically

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
 `PpSql.rewrite_to_sql_method=false` in initializers.

 ### Add to Application record

I sound usefull this trick:

 ```
 class ApplicationRecord < ActiveRecord::Base
  include PpSql::ToSqlBeautify if defined?(Rails::Console)

  self.abstract_class = true
end
```

## License
The gem is available as open source under the terms of the 
[MIT License](http://opensource.org/licenses/MIT).
