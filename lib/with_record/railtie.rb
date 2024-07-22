module WithRecord
  class Railtie < ::Rails::Railtie
    module Extension
      def with_record(record)
        with_records(record)
      end

      def with_records(*records)
        pk         = @klass.primary_key
        record_ids = Array.wrap(records).flatten.compact.collect do |e|
          (e.is_a?(Integer) || e.is_a?(String)) ? e : e.send(pk)      
        end
        @klass.unscoped.where(pk => (self.pluck(pk) + record_ids))
      end
    end

    config.after_initialize do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Relation.send :include, Extension
        ActiveRecord::Associations::CollectionProxy.send :include, Extension
      end
    end
  end
end
