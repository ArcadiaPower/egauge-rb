# Egauge-RB

This is a Ruby wrapper around the Egauge API. It will execute requests from their API and parse the response.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'egauge-rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install egauge-rb

## Usage
Using this gem requires some understanding of the [Egauge API](https://www.egauge.net/docs/egauge-xml-api.pdf).

```ruby
require 'egauge'
client = Egauge::Client.new('http://<device_name>.egaug.es')
```
The Client object implements a `fetch` method which takes hash that needs these keys set:
 - `:timestamp` [Timestamp] - This is the point in time
 from which to fetch past readings. The "latest" reading
 will be the beginning of the current period breakdown.
 For instance, if the timestamp is `2018-10-20 13:06` and
 the breakdown is hourly, the latest reading will be
 from `2018-10-20 13:00`.
 - `:breakdown` [Symbol] - This defines the time period
 between the readings. This can be `:hour`, `:day` or `:month`.
 - `:count` [Integer] - Number of past readings to fetch.

```ruby
options = {
            :timestamp => 2018-10-26 21:47:23 -0400,
            :breakdown => :hour,
            :count => 3
          }
client.fetch(options)
[
  {"Date & Time"=>"1540602000", "Usage [kWh]"=>"0.000000000", "Generation [kWh]"=>"155625.220777500", "Solar [kWh]"=>"155625.220777500", "Solar+ [kWh]"=>"155707.304512778"},
  {"Date & Time"=>"1540598400", "Usage [kWh]"=>"0.000000000", "Generation [kWh]"=>"155625.240751111", "Solar [kWh]"=>"155625.240751111", "Solar+ [kWh]"=>"155707.304512778"},
  {"Date & Time"=>"1540594800", "Usage [kWh]"=>"0.000000000", "Generation [kWh]"=>"155625.262013333", "Solar [kWh]"=>"155625.262013333", "Solar+ [kWh]"=>"155707.304512778"}
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

`Rspec` is used as the testing framework. To test the whole suite, just run the following command.
```ruby
rake spec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ArcadiaPower/egauge-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
