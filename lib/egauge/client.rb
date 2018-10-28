require 'httpclient'
require 'csv'

module Egauge
  class Client
    include Egauge::PowerHelpers

    EGAUGE_PATH = '/cgi-bin/egauge-show?'.freeze

    def initialize(base_url)
      @client = HTTPClient.new(base_url: base_url)
    end

    def fetch(options)
      timestamps = build_timestamps(options)
      params = { T: timestamps.join(","), c: nil }
      query(params)
    end

    private
      attr_reader :client

      def build_timestamps(options)
        end_time    = options[:end_time]
        granularity = options[:granularity]
        iterations  = options[:iterations]

        end_time = end_time.send("beginning_of_#{granularity}".to_sym)
        time_method = "#{granularity}s"
        timestamps = []
        iterations.times do |i|
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
