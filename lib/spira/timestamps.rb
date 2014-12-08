require "spira/timestamps/version"

module Spira
  module Timestamps
    def self.included(model)
      model.before_save :before_save
      model.extend ClassMethods
      model.timestamps
    end

    # Update this model's `updated` time without making any other changes.
    def touch
      update_timestamps
      save
    end

    private

    def before_save
      return unless changed?
      update_timestamps
    end

    def update_timestamps
      update_created
      update_updated
    end

    def update_created
      self.created = self.created || DateTime.now
    end

    def update_updated
      self.updated = DateTime.now
    end

    module ClassMethods
      # Add timestamps to this model.
      def timestamps
        property :created, predicate: RDF::DC.created
        add_created_aliases

        property :updated, predicate: RDF::DC.modified
        add_updated_aliases
      end

      private

      def add_created_aliases
        alias_attribute :created_at, :created

        define_method("created_on") { self.created && self.created.to_date }
        define_method("created_on=") { |date| self.created = date && date.to_datetime }
      end

      def add_updated_aliases
        alias_attribute :updated_at, :updated

        define_method("updated_on") { self.updated && self.updated.to_date }
        define_method("updated_on=") { |date| self.updated = date && date.to_datetime }
      end
    end
  end
end
