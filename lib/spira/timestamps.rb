require "spira/timestamps/version"

module Spira
  module Timestamps
    def self.included(model)
      model.before_save :before_save
      model.extend ClassMethods
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
      update_created if has_created?
      update_updated if has_updated?
    end

    def update_created
      self.created = self.created || DateTime.now
    end

    def update_updated
      self.updated = DateTime.now
    end

    def has_created?
      attributes.keys.include? 'created'
    end

    def has_updated?
      attributes.keys.include? 'updated'
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

        define_method("created_on") do
          self.created && self.created.to_date
        end

        define_method("created_on=") do |date|
          self.created = date && date.to_datetime
        end
      end

      def add_updated_aliases
        alias_attribute :updated_at, :updated

        define_method("updated_on") do
          self.updated && self.updated.to_date
        end

        define_method("updated_on=") do |date|
          self.updated = date && date.to_datetime
        end
      end
    end
  end
end
