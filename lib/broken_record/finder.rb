require 'broken_record/broken_record'

module BrokenRecord
  class Finder

    def self.global
      models_without_descendants = ActiveRecord::Base.descendants.select { |m| m.descendants.empty? }
      new(*models_without_descendants)
    end

    def self.print_report
      global.print_report
    end

    def initialize(*relations)
      @relations = coerce_to_relations(relations)
    end

    def each_broken_record(&block)
      return to_enum(__method__) unless block_given?

      relations.each { |r| each_broken_record_for(r, &block) }
    end

    def print_report
      with_logging_disabled do
        each_broken_record { |r| puts r }
      end

      nil
    end

    private

    attr_reader :relations

    def with_logging_disabled
      logger = ActiveRecord::Base.logger
      ActiveRecord::Base.logger = nil
      yield
      ActiveRecord::Base.logger = logger
    end

    def each_broken_record_for(relation)
      relation.each do |record|
        broken_record = BrokenRecord.new(record)
        yield broken_record if broken_record.broken?
      end
    end

    def coerce_to_relations(relations)
      relations.map { |r| coerce_to_relation(r) }
    end

    def coerce_to_relation(relation)
      relation.ancestors.include?(ActiveRecord::Base) ? relation.all : relation
    end

  end
end
