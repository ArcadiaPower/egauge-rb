require 'httpclient'
require 'csv'

module Egauge
  class Client
    EGAUGE_PATH = '/cgi-bin/egauge-show?'.freeze

    # The base_url should look something like
    # this: 'http://egauge12345.egaug.es'
    def initialize(base_url)
      @client = HTTPClient.new(base_url: base_url)
    end

    # The options hash should have 3 keys defined:
    # 1. :timestamp [Timestamp] - This is the point in time
    #    from which to fetch past readings. The "latest" reading
    #    will be the beginning of the current period breakdown.
    #    For instance if the timestamp is 2018-10-20 13:06 and
    #    the breakdown is hourly, the latest reading will be
    #    from 2018-10-20 13:00
    # 2. :breakdown [Symbol] - This defines the time period
    #    between the readings. This can be :hour, :day or :month
    # 3. :count [Integer] - Number of past readings to fetch
    #
    # This method returns an array of hashes with these values
    #   - "Date & Time" (An integer representing time since epoc)
    #   - "Usage [kWh]"
    #   - "Generation [kWh]"
    #   - "Solar [kWh]"
    #   - "Solar+ [kWh]"
    def fetch(options)
      timestamps = build_timestamps(options)
      params = { T: timestamps.join(","), c: nil }
      query(params)
    end

    private
      attr_reader :client

      def build_timestamps(options)
        timestamp = options[:timestamp]
        breakdown = options[:breakdown]
        count     = options[:count]

        end_time = timestamp.send("beginning_of_#{breakdown}".to_sym)
        time_method = "#{breakdown}s"
        timestamps = []
        count.times do |i|
          timestamps << (end_time - i.send(time_method)).to_i
        end
        timestamps
      end

      def query(params)
        csv_str = client.get(EGAUGE_PATH + query_string(params)).body
        records = []
        CSV.parse(csv_str, headers: true){|l| records << l.to_h }
        records
      end

      def query_string(params)
        params.stringify_keys.map do |key, value|
          query_parameter = key.dup
          query_parameter << "=#{value.to_s}" unless value.nil?
          query_parameter
        end.join('&')
      end
  end
end
