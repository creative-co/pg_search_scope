module PgSearchScope
  module MigrationHelper
    def add_fulltext_index table_name, column_name, options = {}
      options[:language] ||= PgSearchScope::ModelHelper::DEFAULT_OPTIONS[:language]
      column_names = Array.wrap(column_name)
      index_name = options[:name].presence || index_name(table_name, :column => column_names) + '_ftx'
      execute(<<-"eosql".strip)
      CREATE INDEX #{index_name} ON #{table_name}
      USING GIN(TO_TSVECTOR('#{options[:language]}', #{column_names.map { |name| "COALESCE(\"#{table_name}\".\"#{name}\", '')" }.join(" || ' ' || ")}))
      eosql
    end

    def remove_fulltext_index table_name, options = {}
      index_name = index_name(table_name, options) + '_ftx'
      execute(<<-"eosql".strip)
      DROP INDEX IF EXISTS #{index_name}
      eosql
    end
  end
end

ActiveRecord::Migration.send :extend, PgSearchScope::MigrationHelper