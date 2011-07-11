### PG Search Scope

PostgreSQL full text search using Rails 3 scopes

## Basic usage

Include `gem pg_search_scope` in your `Gemfile`

In model, use `search_scope_for` class method to create full text search scope.

Examples:

    search_scope_for :name
    -->
    search_by_name("Ivan")


In migration, use `add_fulltext_index` / `remove_fulltext_index` the same way as `add_index` / `remove_index`

## Advanced usage

You can set additional search options:

    :as - Scope name

    :normalization - Controls rank behaviour, see http://www.postgresql.org/docs/9.0/static/textsearch-controls.html#TEXTSEARCH-RANKING

    :wildcard - Controls search words modification:
                     true - add :* to ends of each search word
                     false - do not modify search words
                     :last - add :* to end of last word

    :operator - Boolean operator (:and or :or) which combines search query

    :select_rank - Include rank in select statement, as {scope_name}_rank

    :language - Search language, e.g. 'simple' (without magic), 'english'

If you use `:language` option, you need to use the same option for `add_fulltext_index`

Examples:

    search_scope_for :name, :address,
                     :wildcard => :last
    -->
    search_by_name_and_address("Ivan, Aurora st.", :select_rank => true)


## To do

...

## Copyright

Copyright (c) 2011 Ivan Efremov, Ilia Ablamonov, Cloud Castle Inc.
See LICENSE for details.