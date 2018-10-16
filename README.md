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

### Basic Query
Queries return response objects that can be interacted with. More details on the response object are found below.
```ruby
require 'egauge'
client = Egauge::Client.new('http://<device_name>.egaug.es')
# This nil is necessary because the query structure is 'h&n=24'
client.query(:h => nil, :n => 24, :f => 1522800000)
```
### Helper query
There are helpers to query data for you without having to craft queries. These also return response objects.
```ruby
require 'egauge'
client = Egauge::Client.new('http://<device_name>.egaug.es')
client.full_day_kwh
```

### Egauge response object
Queries will return a response object. That object will have reader methods for each header that will return the rows of that header.

If you're unsure what your headers are, there is a method you can use to find out!

```ruby
require 'egauge'
client = Egauge::Client.new('http://<device_name>.egaug.es')
response = client.query(:h => nil, :n => 24, :f => 1522800000)

response.headers
=> ["solar", "solar2"]

response.solar
=> [123412341234, 123412341234, 123412341234]

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ArcadiaPower/egauge-rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
