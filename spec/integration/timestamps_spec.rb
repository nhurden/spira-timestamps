require 'spec_helper'

describe "Spira::Timestamps" do
  shared_examples "a timestamped resource" do
    context "creating a new resource" do
      it "does not override existing created dates" do
        bob = Person.new(name: "Bob")
        past_dt = DateTime.now - 123
        bob.created = past_dt
        bob.save

        expect(bob.created_at).to eq(past_dt)
        expect(bob.created_on).to eq(past_dt.to_date)
      end

      it "sets the created dates if not already set" do
        bob = Person.new(name: "Bob")

        expect(bob.created_at).to be_nil
        expect(bob.created_on).to be_nil
        expect(bob.created).to be_nil

        bob.save

        expect(bob.created_at).to be_a(DateTime)
        expect(bob.created_on).to be_a(Date)
        expect(bob.created).to eq(bob.created_at)
      end

      it "sets the updated_at and updated_on dates" do
        bob = Person.new(name: "Bob").save

        expect(bob.updated_at).to be_a(DateTime)
        expect(bob.updated_on).to be_a(Date)
        expect(bob.updated).to eq(bob.updated_at)
      end
    end

    context "modifying a resource" do
      it "does not update the created_at and created_on dates" do
        bob = Person.new(name: "Bob").save

        old_created_at = bob.created_at
        old_created_on = bob.created_on

        bob.name = "Bob Two"
        bob.save

        expect(bob.created_at).to eq(old_created_at)
        expect(bob.created_on).to eq(old_created_on)
      end

      it "updates the updated_at and updated_on dates" do
        bob = Person.new(name: "Bob").save

        old_updated_at = bob.updated_at
        old_updated_on = bob.updated_on

        tomorrow = DateTime.now + 1
        allow(DateTime).to receive(:now).and_return(tomorrow)

        bob.name = "Bob Two"
        bob.save

        expect(bob.updated_at).to_not eq(old_updated_at)
        expect(bob.updated_on).to_not eq(old_updated_on)

        expect(bob.updated_at).to eq(tomorrow)
        expect(bob.updated_on).to eq(tomorrow.to_date)
      end
    end

    context "saving a clean resource" do
      it "does not update the updated_at and updated_on dates" do
        bob = Person.new(name: "Bob").save

        old_updated_at = bob.updated_at
        old_updated_on = bob.updated_on

        bob.save

        expect(bob.updated_at).to eq(old_updated_at)
        expect(bob.updated_on).to eq(old_updated_on)
      end
    end

    context "touching a resource" do
      it "updates the updated_at and updated_on dates" do
        bob = Person.new(name: "Bob").save

        now = DateTime.now
        allow(DateTime).to receive(:now).and_return(now)

        bob.touch

        expect(bob.updated_at).to eq(now)
        expect(bob.updated_on).to eq(now.to_date)
      end

      it "does not update the created_at and created_on dates" do
        bob = Person.new(name: "Bob").save

        old_created_at = bob.created_at
        old_created_on = bob.created_on

        bob.touch

        expect(bob.created_at).to eq(old_created_at)
        expect(bob.created_on).to eq(old_created_on)
      end
    end
  end

  describe "implicitly defined timestamps" do
    before do
      Object.send(:remove_const, :Person) if defined? Person

      class Person < Spira::Base
        include Spira::Timestamps

        configure :base_uri => "http://example.org/example/people"
        property :name, predicate: FOAF.name, type: String
      end
    end

    it_behaves_like "a timestamped resource"
  end
end
