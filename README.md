# PpSql

Replace standard `ActiveRecord#to_sql` method with [`anbt-sql-formatter`](https://github.com/sonota88/anbt-sql-formatter)
gem for pretty SQL code output in console. Rails log will be formatted also. Example output:

![log](http://savepic.ru/12566050.png)

Or in console

![console] (http://savepic.ru/12578341.png)

## Require

Ruby 2.0+

## Usage

```
Post.first.to_sql
```

If you need yo use it in some custom strings, you may include this funcionality with

```
String.send :include, PpSql::ToSqlBeautify
```

and use formatter with any String.

## Installation

add in Gemfile
```
gem 'pp_sql', group :development
```

And then execute:
```bash
$ bundle
```

## With other formatters

If you are `pry` user, or use custom output formatter, use `puts` for output whitespaces, 
like `puts User.all.to_sql`, or use `User.all.pp_sql`

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
