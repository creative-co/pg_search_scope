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
  
  module CommandRecorder
    def add_fulltext_index *args
      record(:add_fulltext_index, args)
    end
    
    def invert_add_fulltext_index(args)
      table, columns, options = *args
      index_name = options.try(:[], :name)
      options_hash =  index_name ? {:name => index_name} : {:column => columns}
      [:remove_fulltext_index, [table, options_hash]]
    end
  end
end

require 'active_record/connection_adapters/postgresql_adapter'

ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send :include,  PgSearchScope::MigrationHelper
ActiveRecord::Migration::CommandRecorder.send :include, PgSearchScope::CommandRecorder
