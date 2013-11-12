require 'broken_record/reference'

module BrokenRecord
  class BrokenRecord

    def initialize(record)
      @record = record
    end

    def broken?
      broken_references.count > 0
    end

    def to_s
      "#{record.class} (id=#{record.id}) broken because of nil #{broken_references.join(', ')}"
    end

    def broken_references
      @broken_references ||= begin
        references = []
        belongs_to_associations.each do |association|
          related_record_klass = association.class_name.constantize rescue next
          related_record_id = record.public_send(association.foreign_key)
          reference = Reference.new(related_record_klass, related_record_id)
          references << reference if reference.broken?
        end
        references
      end
    end

    private

    attr_reader :record

    def belongs_to_associations
      @belongs_to_associations ||= candidate_belongs_to_associations.select { |a| association_matches?(a) }
    end

    def model
      record.class
    end

    def candidate_belongs_to_associations
      model.reflect_on_all_associations(:belongs_to)
    end

    def association_matches?(association)
      true
    end

  end
end
