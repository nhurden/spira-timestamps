# spira-timestamps [![Build Status](https://travis-ci.org/nhurden/spira-timestamps.svg?branch=develop)](https://travis-ci.org/nhurden/spira-timestamps)

Add automatic timestamps to your Spira models.

spira-timestamps adds `created` and `updated` `DateTime` attributes to
your model with the Dublin Core [`created`](http://purl.org/dc/terms/created) and
[`modified`](http://purl.org/dc/terms/modified) predicates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spira-timestamps'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spira-timestamps

## Usage

To add timestamps to a model, just add `include Spira::Timestamps` to
your model class.

For example:
```ruby
class Person < Spira::Base
  include Spira::Timestamps

  property :name, predicate: FOAF.name, type: String
end
```

Timestamps are updated automatically when you `save` your model.

You can access the timestamps either as `DateTime` objects via the
`created_at` and `updated_at` properties or as `Date` objects via the
`created_on` and `updated_on` properties. For example:

    > bob = Person.new(name: 'Bob').save
    => <Person:2170778720 @subject: _:g2170778680> 
    > bob.created_at
    => #<DateTime: 2014-12-08T20:48:27+11:00 ...>
    > bob.created_on
    => #<Date: 2014-12-08 ...>
    > bob.touch
    => <Person:2170778720 @subject: _:g2170778680> 
    > bob.updated_at
    => #<DateTime: 2014-12-08T20:49:41+11:00 ...>
    > bob.updated_on
    => #<Date: 2014-12-08 ...>

## Contributing

1. Fork it ( https://github.com/nhurden/spira-timestamps/fork )
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request
